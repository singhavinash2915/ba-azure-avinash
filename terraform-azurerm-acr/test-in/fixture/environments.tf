module "rg" {
  source   = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-rg"
  location = local.location
  name     = "BASF_RG_AllowPE_${local.prefix_snake}_rg"

}

data "azurerm_virtual_network" "vn" {
  name                = "BASF_VN_IN_${data.azurerm_subscription.current.display_name}"
  resource_group_name = "BASF_RG_Network_${data.azurerm_subscription.current.display_name}"
}
module "privateendpointacr" {
  source              = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-privateendpoint"
  location            = data.azurerm_virtual_network.vn.location
  resource_group_name = module.rg.resource_group_name
  pe_name             = "${local.prefix_kebab}-${local.hash_suffix}-acr-pe"
  subnet_id           = local.subnet_id
  target_resource     = module.acr.acr_id
  subresource_names   = ["registry"]
}