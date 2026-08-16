resource "azurerm_virtual_network" "hub" {
  name                = "vnet-${var.prefix}-${var.environment}-hub"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.hub_address_space
  tags                = var.tags
}

resource "azurerm_virtual_network" "spoke" {
  name                = "vnet-${var.prefix}-${var.environment}-spoke01"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.spoke_address_space
  tags                = var.tags
}

resource "azurerm_subnet" "hub" {
  for_each = var.hub_subnet_prefixes

  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = each.value
}

resource "azurerm_subnet" "spoke" {
  for_each = var.spoke_subnet_prefixes

  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.spoke.name
  address_prefixes     = each.value
}

resource "azurerm_network_security_group" "workload" {
  name                = "nsg-${var.prefix}-${var.environment}-workload"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_subnet_network_security_group_association" "workload" {
  for_each = azurerm_subnet.spoke

  subnet_id                 = each.value.id
  network_security_group_id = azurerm_network_security_group.workload.id
}

resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  name                      = "peer-hub-to-spoke"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = azurerm_virtual_network.hub.name
  remote_virtual_network_id = azurerm_virtual_network.spoke.id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  name                      = "peer-spoke-to-hub"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = azurerm_virtual_network.spoke.name
  remote_virtual_network_id = azurerm_virtual_network.hub.id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}
