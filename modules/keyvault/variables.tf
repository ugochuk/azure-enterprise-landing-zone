variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "prefix" { type = string }
variable "environment" { type = string }
variable "private_endpoint_subnet_id" { type = string }
variable "spoke_vnet_id" { type = string }
variable "tags" { type = map(string) }
