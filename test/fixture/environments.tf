module "rg" {
  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-rg"

  name     = "${local.prefix_snake}_rg"
  location = local.location

}