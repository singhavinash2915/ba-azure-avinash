module "rg" {
  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-rg"

  name     = "${local.prefix_snake}_rg"
  location = local.location

}

module "vnet" {
  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-vnet"

  vnet_name           = "${local.prefix_kebab}-${local.hash_suffix}-vnet"
  location            = module.rg.resource_group_location
  resource_group_name = module.rg.resource_group_name
  vnet_cidr           = ["10.0.0.0/20"]


  subnets = {
    subnet_backend = {
      subnet_address_prefix = ["10.0.1.0/24"]
      service_endpoints     = ["Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.Sql", "Microsoft.Web"]
    },
    subnet_frontend = {
      subnet_address_prefix = ["10.0.2.0/24"]
      service_endpoints     = ["Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.Sql", "Microsoft.Web"]
    },
    subnet_management = {
      subnet_address_prefix = ["10.0.3.0/24"]
      service_endpoints     = ["Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.Sql", "Microsoft.Web"]
    }
  }
}
