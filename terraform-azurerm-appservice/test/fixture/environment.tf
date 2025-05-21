module "rg" {
  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-rg"

  name     = "${local.prefix_snake}_rg"
  location = local.location

}
module "rgw" {
  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-rg"

  name     = "${local.prefix_snake}_rgw"
  location = local.location

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
module "vnet_lx" {
  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-vnet"

  vnet_name           = "${local.prefix_kebab}-${local.hash_suffix}-vnet-lx"
  location            = module.rg.resource_group_location
  resource_group_name = module.rg.resource_group_name
  vnet_cidr           = ["10.0.0.0/20"]

  subnets = {
    subnet-backend = {

      subnet_address_prefix = ["10.0.1.0/24"]
      service_endpoints     = ["Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.Sql", "Microsoft.Web"]

      delegation = {
        name = "app-service-plan"
        service_delegation = {
          name    = "Microsoft.Web/serverFarms"
          actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
        }
      }
    }
  }
}

module "vnet_win" {
  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-vnet"

  vnet_name           = "${local.prefix_kebab}-${local.hash_suffix}-vnet-win"
  location            = module.rgw.resource_group_location
  resource_group_name = module.rgw.resource_group_name
  vnet_cidr           = ["10.1.0.0/20"]

  subnets = {
    subnet-backend = {

      subnet_address_prefix = ["10.1.1.0/24"]
      service_endpoints     = ["Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.Sql", "Microsoft.Web"]

      delegation = {
        name = "app-service-plan"
        service_delegation = {
          name    = "Microsoft.Web/serverFarms"
          actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
        }
      }
    }
  }
}
