variable "environment" {
  description = "Deployment environment name."
  type        = string

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "Environment must be dev, test, or prod."
  }
}

variable "location" {
  description = "Azure region used for landing zone resources."
  type        = string
  default     = "eastus2"
}

variable "prefix" {
  description = "Short naming prefix used across resources."
  type        = string
  default     = "rugo"
}

variable "hub_address_space" {
  description = "CIDR address space for the hub virtual network."
  type        = list(string)
}

variable "spoke_address_space" {
  description = "CIDR address space for the workload spoke virtual network."
  type        = list(string)
}

variable "hub_subnet_prefixes" {
  description = "CIDR prefixes for hub subnets."
  type        = map(list(string))
}

variable "spoke_subnet_prefixes" {
  description = "CIDR prefixes for spoke subnets."
  type        = map(list(string))
}

variable "tags" {
  description = "Additional tags applied to resources."
  type        = map(string)
  default     = {}
}
