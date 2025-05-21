module "rg" {
  source   = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-rg"
  location = local.location
  name     = "BASF_RG_AllowPE_${local.prefix_snake}_rg"
}

data "azurerm_virtual_network" "vn" {
  name                = "BASF_VN_IN_${data.azurerm_subscription.current.display_name}"
  resource_group_name = "BASF_RG_Network_${data.azurerm_subscription.current.display_name}"
}