locals {
  // Subnet id
  subnet_id = "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/BASF_RG_Network_${data.azurerm_subscription.current.display_name}/providers/Microsoft.Network/virtualNetworks/BASF_VN_IN_${data.azurerm_subscription.current.display_name}/subnets/BASF_SN_IN_${data.azurerm_subscription.current.display_name}${var.subnet_intranet_name_suffix}"
  // Webapp Subnet id
  # webapp_subnet_id = "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/BASF_RG_Network_${data.azurerm_subscription.current.display_name}/providers/Microsoft.Network/virtualNetworks/BASF_VN_IN_${data.azurerm_subscription.current.display_name}/subnets/BASF_SN_IN_${data.azurerm_subscription.current.display_name}${var.subnet_webapp_name_suffix}"
}
module "storage" {
  source                           = "./../.." # Use the local version to test it
  name                             = "${local.prefix_flat}${local.hash_suffix}sa"
  location                         = module.rg.resource_group_location
  resource_group_name              = module.rg.resource_group_name
  cross_tenant_replication_enabled = true

  public_network_access_enabled = false

  allow_nested_items_to_be_public = true
  shared_access_key_enabled       = true
  //containers could not be created via Terraform script due to then extisting network restrictions

}

module "privateendpointstorageblob" {
  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-privateendpoint"

  location            = data.azurerm_virtual_network.vn.location
  resource_group_name = module.rg.resource_group_name
  pe_name             = "${local.prefix_kebab}-${local.hash_suffix}-pendpstorageblob"
  subnet_id           = local.subnet_id
  target_resource     = module.storage.storage_id
  subresource_names   = ["blob"]
}


module "storagefile" {
  source              = "./../.." # Use the local version to test it
  name                = "${local.prefix_flat}${local.hash_suffix}saf"
  location            = module.rg.resource_group_location
  resource_group_name = module.rg.resource_group_name


  public_network_access_enabled = false

  allow_nested_items_to_be_public = true
  shared_access_key_enabled       = true
  //files could not be created via Terraform script due to then extisting network restrictions

}

module "privateendpointstoragefile" {
  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-privateendpoint"

  location            = data.azurerm_virtual_network.vn.location
  resource_group_name = module.rg.resource_group_name
  pe_name             = "${local.prefix_kebab}-${local.hash_suffix}-pendpstoragefile"
  subnet_id           = local.subnet_id
  target_resource     = module.storagefile.storage_id
  subresource_names   = ["file"]
}

# Example for hosting Static WebSites in Azure Storage with a Private Endpoint
module "storagestaticwebsite" {
  source              = "./../.." # Use the local version to test it
  name                = "${local.prefix_flat}${local.hash_suffix}web"
  location            = module.rg.resource_group_location
  resource_group_name = module.rg.resource_group_name
  min_tls_version     = "TLS1_2"

  public_network_access_enabled   = false
  allow_nested_items_to_be_public = true
  shared_access_key_enabled       = true

  static_website_enabled = true # enable static website

}

module "privateendpointstoragesweb" {
  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-privateendpoint"

  location            = data.azurerm_virtual_network.vn.location
  resource_group_name = module.rg.resource_group_name
  pe_name             = "${local.prefix_kebab}-${local.hash_suffix}-pendpstoragesweb"
  subnet_id           = local.subnet_id
  target_resource     = module.storagestaticwebsite.storage_id
  subresource_names   = ["Web"]
}
