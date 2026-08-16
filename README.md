# Azure Enterprise Landing Zone with Terraform

Enterprise-style Azure landing zone built with Terraform to demonstrate reusable infrastructure modules, secure networking, identity, governance, and operational readiness.

## What this project demonstrates

- Infrastructure as Code with Terraform
- Reusable Azure infrastructure modules
- Hub-and-spoke virtual networking
- Network security groups and subnet segmentation
- Private DNS and private connectivity patterns
- Log Analytics monitoring foundation
- Managed identity and RBAC patterns
- Environment-specific configuration
- Production-minded naming, tagging, and outputs

## Architecture

The reference architecture uses a hub-and-spoke network model:

```text
                    +-----------------------+
                    |   Azure Subscription  |
                    +-----------+-----------+
                                |
              +-----------------+-----------------+
              |                                   |
      +-------v--------+                  +-------v--------+
      |   Hub VNet     |<---------------->|   Spoke VNet   |
      | 10.10.0.0/16   |   VNet Peering   | 10.20.0.0/16   |
      +-------+--------+                  +-------+--------+
              |                                   |
      +-------v--------+                  +-------v--------+
      | Shared Services|                  | Workload Subnet|
      | / Management   |                  | App / Platform |
      +----------------+                  +----------------+
              |
      +-------v--------+
      | Log Analytics  |
      +----------------+
```

The project intentionally focuses on infrastructure patterns rather than deploying a business application. It is designed as a portfolio reference for cloud/platform engineering work.

## Repository structure

```text
.
├── environments/
│   ├── dev/
│   └── prod/
├── modules/
│   ├── network/
│   └── monitoring/
├── main.tf
├── providers.tf
├── variables.tf
├── outputs.tf
└── versions.tf
```

## Core design decisions

### Hub-and-spoke networking

A hub-and-spoke model separates shared connectivity from application workloads and provides a scalable foundation for adding additional workload networks later.

### Reusable Terraform modules

Networking and monitoring resources are implemented as modules so the same patterns can be consumed consistently across multiple environments.

### Environment separation

Development and production use separate variable files, allowing infrastructure to remain consistent while CIDR ranges, naming, and sizing vary by environment.

### Security-first defaults

The implementation favors private networking patterns, explicit subnet definitions, centralized logging, and standardized tagging. Public exposure is intentionally minimized.

## Prerequisites

- Terraform >= 1.6
- Azure CLI
- An Azure subscription
- Appropriate Azure RBAC permissions

Authenticate with Azure:

```bash
az login
az account set --subscription <subscription-id>
```

## Deploy

Initialize Terraform:

```bash
terraform init
```

Review the development plan:

```bash
terraform plan -var-file=environments/dev/terraform.tfvars
```

Deploy:

```bash
terraform apply -var-file=environments/dev/terraform.tfvars
```

## Security note

This repository is an original portfolio project and does not contain proprietary code, customer data, tenant IDs, subscription IDs, credentials, or internal configuration from any employer.

## Roadmap

- Add Azure Firewall integration
- Add private endpoint example
- Add Key Vault and managed identity module
- Add Azure Policy assignments
- Add GitHub Actions validation workflow
- Add architecture diagram
- Add automated Terraform tests
