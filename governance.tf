data "azurerm_subscription" "current" {}

resource "azurerm_subscription_policy_assignment" "require_environment_tag" {
  name                 = "require-environment-tag"
  subscription_id      = data.azurerm_subscription.current.id
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/871b6d14-10aa-478d-b590-94f262ecfa99"
  display_name         = "Require Environment tag on resources"
  description          = "Portfolio example of subscription-level governance enforced through Azure Policy."

  parameters = jsonencode({
    tagName = {
      value = "Environment"
    }
  })
}
