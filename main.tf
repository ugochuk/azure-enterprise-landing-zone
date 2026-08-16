locals {
  common_tags = merge(
    {
      Environment = var.environment
      ManagedBy   = "Terraform"
      Project     = "AzureEnterpriseLandingZone"
    },
    var.tags
  )
}

resource "azurerm_resource_group" "network" {
  name     = "rg-${var.prefix}-${var.environment}-network"
  location = var.location
  tags     = local.common_tags
}

resource "azurerm_resource_group" "management" {
  name     = "rg-${var.prefix}-${var.environment}-management"
  location = var.location
  tags     = local.common_tags
}

module "network" {
  source = "./modules/network"

  resource_group_name   = azurerm_resource_group.network.name
  location              = var.location
  prefix                = var.prefix
  environment           = var.environment
  hub_address_space     = var.hub_address_space
  spoke_address_space   = var.spoke_address_space
  hub_subnet_prefixes   = var.hub_subnet_prefixes
  spoke_subnet_prefixes = var.spoke_subnet_prefixes
  tags                  = local.common_tags
}

module "monitoring" {
  source = "./modules/monitoring"

  resource_group_name = azurerm_resource_group.management.name
  location            = var.location
  prefix              = var.prefix
  environment         = var.environment
  tags                = local.common_tags
}

module "keyvault" {
  source = "./modules/keyvault"

  resource_group_name       = azurerm_resource_group.management.name
  location                  = var.location
  prefix                    = var.prefix
  environment               = var.environment
  private_endpoint_subnet_id = module.network.spoke_subnet_ids["snet-data"]
  spoke_vnet_id             = module.network.spoke_vnet_id
  tags                      = local.common_tags
}
