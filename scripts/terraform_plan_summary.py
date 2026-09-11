#!/usr/bin/env python3
"""Summarize Terraform plan JSON for CI/CD review.

Designed as a sanitized portfolio implementation of a pipeline control that
parses `terraform show -json` output, classifies resource actions, validates
required configuration, and emits a machine-readable summary.
"""

import argparse
import json
import sys
from collections import Counter
from pathlib import Path
from typing import Any, Dict


def classify(plan: Dict[str, Any]) -> Counter:
    counts: Counter = Counter()
    for change in plan.get("resource_changes", []):
        actions = change.get("change", {}).get("actions", [])
        if actions == ["create"]:
            counts["create"] += 1
        elif actions == ["update"]:
            counts["update"] += 1
        elif actions == ["delete"]:
            counts["delete"] += 1
        elif "delete" in actions and "create" in actions:
            counts["replace"] += 1
        elif actions == ["no-op"]:
            counts["no_op"] += 1
        else:
            counts["other"] += 1
    return counts


def validate(plan: Dict[str, Any]) -> list[str]:
    errors: list[str] = []
    terraform_version = plan.get("terraform_version")
    if not terraform_version:
        errors.append("terraform_version is missing")
    if "resource_changes" not in plan:
        errors.append("resource_changes is missing")
    return errors


def main() -> int:
    parser = argparse.ArgumentParser(description="Analyze Terraform plan JSON")
    parser.add_argument("plan", type=Path, help="Path to plan_output.json")
    parser.add_argument("--output", type=Path, help="Optional JSON summary path")
    args = parser.parse_args()

    try:
        plan = json.loads(args.plan.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError) as exc:
        print(f"ERROR: unable to read Terraform plan: {exc}", file=sys.stderr)
        return 2

    errors = validate(plan)
    summary = {
        "terraform_version": plan.get("terraform_version"),
        "actions": dict(classify(plan)),
        "validation_errors": errors,
    }

    rendered = json.dumps(summary, indent=2, sort_keys=True)
    print(rendered)
    if args.output:
        args.output.write_text(rendered + "\n", encoding="utf-8")

    return 1 if errors else 0


if __name__ == "__main__":
    raise SystemExit(main())
