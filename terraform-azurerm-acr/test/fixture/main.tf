# For E2E test for this module
module "acr" {
  source              = "./../.." # Use the local version to test it
  name                = "${local.prefix_flat}${local.hash_suffix}"
  location            = module.rg.resource_group_location
  resource_group_name = module.rg.resource_group_name
  sku                 = "Standard"
  admin_enabled       = true
}


module "acr_premium" {
  source              = "./../.." # Use the local version to test it
  name                = "${local.prefix_flat}${local.hash_suffix}p"
  location            = module.rg.resource_group_location
  resource_group_name = module.rg.resource_group_name
  sku                 = "Premium"
  admin_enabled       = false
  identity = {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.mi_acr.id]
  }
  allowed_cidrs = ["128.246.11.0/24", "40.74.28.0/23", "20.166.41.0/24"] //GPC LU and Azure devops Server Europe
}
