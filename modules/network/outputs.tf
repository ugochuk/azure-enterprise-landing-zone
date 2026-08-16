output "hub_vnet_id" {
  description = "Resource ID of the hub virtual network."
  value       = azurerm_virtual_network.hub.id
}

output "spoke_vnet_id" {
  description = "Resource ID of the workload spoke virtual network."
  value       = azurerm_virtual_network.spoke.id
}

output "hub_subnet_ids" {
  description = "Map of hub subnet names to resource IDs."
  value       = { for name, subnet in azurerm_subnet.hub : name => subnet.id }
}

output "spoke_subnet_ids" {
  description = "Map of spoke subnet names to resource IDs."
  value       = { for name, subnet in azurerm_subnet.spoke : name => subnet.id }
}
