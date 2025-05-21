
module "rg" {
  source   = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-rg"
  location = data.azurerm_virtual_network.vn.location
  name     = "BASF_RG_AllowPE_${local.prefix_snake}_rg"
}

module "rgw" {
  source   = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-rg"
  location = data.azurerm_virtual_network.vn.location
  name     = "BASF_RG_AllowPE_${local.prefix_snake}_rgw"
}


data "azurerm_virtual_network" "vn" {
  name                = "BASF_VN_IN_${data.azurerm_subscription.current.display_name}"
  resource_group_name = "BASF_RG_Network_${data.azurerm_subscription.current.display_name}"
}

module "app_service_plan" {
  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-asp"

  app_service_plan_name = "${local.prefix_kebab}-${local.hash_suffix}-asp"
  location              = module.rg.resource_group_location
  resource_group_name   = module.rg.resource_group_name
  os_type               = "Linux"
  sku_name              = "P1v2"
}


module "app_service_plan_w" {
  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-asp"

  app_service_plan_name = "${local.prefix_kebab}-${local.hash_suffix}-aspw"
  location              = module.rgw.resource_group_location
  resource_group_name   = module.rgw.resource_group_name
  os_type               = "Windows"
  sku_name              = "P1v2"

}

module "app_insights" {
  source              = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appinsights"
  app_insights_name   = "${local.prefix_kebab}-${local.hash_suffix}"
  location            = module.rg.resource_group_location
  resource_group_name = module.rg.resource_group_name
  application_type    = "web"
}