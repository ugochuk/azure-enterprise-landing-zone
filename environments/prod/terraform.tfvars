environment = "prod"
location    = "eastus2"
prefix      = "rugo"

hub_address_space   = ["10.100.0.0/16"]
spoke_address_space = ["10.110.0.0/16"]

hub_subnet_prefixes = {
  "snet-management" = ["10.100.1.0/24"]
  "snet-shared"     = ["10.100.2.0/24"]
}

spoke_subnet_prefixes = {
  "snet-app"  = ["10.110.1.0/24"]
  "snet-data" = ["10.110.2.0/24"]
}

tags = {
  Owner      = "CloudPlatform"
  CostCenter = "Portfolio"
}
