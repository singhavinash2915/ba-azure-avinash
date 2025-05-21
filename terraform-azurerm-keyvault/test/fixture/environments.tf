module "rg" {
  source   = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-rg"
  location = local.location
  name     = "${local.prefix_snake}_rg"
}