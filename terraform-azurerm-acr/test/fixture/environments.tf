module "rg" {
  source   = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-rg"
  location = local.location
  name     = "${local.prefix_snake}_rg"
}


resource "azurerm_user_assigned_identity" "mi_acr" {
  location            = var.location
  resource_group_name = module.rg.resource_group_name
  name                = "${local.prefix_kebab}-${local.hash_suffix}-mi-acr"
}
