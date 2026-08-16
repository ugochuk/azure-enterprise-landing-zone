output "hub_vnet_id" {
  description = "Resource ID of the hub virtual network."
  value       = module.network.hub_vnet_id
}

output "spoke_vnet_id" {
  description = "Resource ID of the workload spoke virtual network."
  value       = module.network.spoke_vnet_id
}

output "log_analytics_workspace_id" {
  description = "Resource ID of the centralized Log Analytics workspace."
  value       = module.monitoring.log_analytics_workspace_id
}
