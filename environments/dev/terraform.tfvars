environment = "dev"
location    = "eastus2"
prefix      = "rugo"

hub_address_space   = ["10.10.0.0/16"]
spoke_address_space = ["10.20.0.0/16"]

hub_subnet_prefixes = {
  "snet-management" = ["10.10.1.0/24"]
  "snet-shared"     = ["10.10.2.0/24"]
}

spoke_subnet_prefixes = {
  "snet-app"  = ["10.20.1.0/24"]
  "snet-data" = ["10.20.2.0/24"]
}

tags = {
  Owner      = "CloudPlatform"
  CostCenter = "Portfolio"
}
