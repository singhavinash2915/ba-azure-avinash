module "storage" {
  source                             = "./../.." # Use the local version to test it
  name                               = "${local.prefix_flat}${local.hash_suffix}sa"
  location                           = module.rg.resource_group_location
  resource_group_name                = module.rg.resource_group_name
  min_tls_version                    = "TLS1_2"
  storage_vnet_integration_subnet_id = [module.vnet.named_subnet_ids["subnet_backend"], module.vnet.named_subnet_ids["subnet_management"]]
  storage_public_ip_list_allowed     = ["18.158.255.211/24", "20.113.58.168/24"]
  # Be carful with default_action = "Deny" -> see input parameter documentation
  default_action = "Allow"

  allow_nested_items_to_be_public = true
  shared_access_key_enabled       = false
  containers = [
    {
      name        = "data"
      access_type = "private"
    }
  ]
}

# Example for hosting Static WebSites in Azure Storage in one Region
module "storagestaticwebsite" {
  source              = "./../.." # Use the local version to test it
  name                = "${local.prefix_flat}${local.hash_suffix}web"
  location            = module.rg.resource_group_location
  resource_group_name = module.rg.resource_group_name
  min_tls_version     = "TLS1_2"

  # Be carful with default_action = "Deny" -> see input parameter documentation
  default_action = "Allow"

  # sku                    = "Standard_LRS" # this is the default value
  static_website_enabled = true

}

# Example for hosting Static WebSites in Azure Storage in multiple Regions with read access
module "storagestaticwebsiteRAGRS" {
  source              = "./../.." # Use the local version to test it
  name                = "${local.prefix_flat}${local.hash_suffix}ragr"
  location            = module.rg.resource_group_location
  resource_group_name = module.rg.resource_group_name
  min_tls_version     = "TLS1_2"

  # Be carful with default_action = "Deny" -> see input parameter documentation
  default_action = "Allow"

  sku                    = "Standard_RAGRS"
  static_website_enabled = true
}

module "storageiplist" {
  source              = "./../.." # Use the local version to test it
  name                = "${local.prefix_flat}${local.hash_suffix}ipl"
  location            = module.rg.resource_group_location
  resource_group_name = module.rg.resource_group_name
  min_tls_version     = "TLS1_2"

  public_network_access_enabled  = false
  default_action                 = "Deny"
  storage_public_ip_list_allowed = ["3.64.180.95", "18.159.237.194"]
}
