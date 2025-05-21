locals {
  # Subnet ID for the App Service Ingress Integration. This reflects you BCN connected vnet.
  subnet_id = "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/BASF_RG_Network_${data.azurerm_subscription.current.display_name}/providers/Microsoft.Network/virtualNetworks/BASF_VN_IN_${data.azurerm_subscription.current.display_name}/subnets/BASF_SN_IN_${data.azurerm_subscription.current.display_name}${var.subnet_intranet_name_suffix}"
  # Webapp Subnet id for the App Service VNet Integration. This reflects you BCN connected vnet.
  subnet_id_out = "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/BASF_RG_Network_${data.azurerm_subscription.current.display_name}/providers/Microsoft.Network/virtualNetworks/BASF_VN_IN_${data.azurerm_subscription.current.display_name}/subnets/BASF_SN_IN_${data.azurerm_subscription.current.display_name}${var.subnet_webapp_name_suffix}"
}
module "app_service_container" {
  source = "./../.." # Use the local version to test it

  app_service_name    = "${local.prefix_kebab}-${local.hash_suffix}-webcont"
  location            = module.rg.resource_group_location
  resource_group_name = module.rg.resource_group_name
  os_type             = "Container"
  app_service_plan_id = module.app_service_plan.app_service_plan_id


  application_insights_instrumentation_key = module.app_insights.application_insights_instrumentation_key
  application_insights_connection_string   = module.app_insights.application_insights_connection_string

  staging_slot_enabled = false

  docker_image = {
    name = "helloworldcontainers/java-spring-boot-hello-world"
  }

  site_config = {
  }
  app_service_vnet_integration_subnet_id = [local.subnet_id_out]
  app_settings = {
    foo   = "bar"
    stage = terraform.workspace
  }

  public_network_access_enabled = false

}
module "privateendpointweb" {

  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-privateendpoint"

  location            = module.rg.resource_group_location
  resource_group_name = module.rg.resource_group_name
  pe_name             = "${local.prefix_kebab}-${local.hash_suffix}-pendpweb"
  subnet_id           = local.subnet_id
  target_resource     = module.app_service_container.app_service_id

  subresource_names = ["sites"]
}

module "app_service_linux" {
  source = "./../.." # Use the local version to test it

  app_service_name    = "${local.prefix_kebab}-${local.hash_suffix}-weblx"
  location            = module.rg.resource_group_location
  resource_group_name = module.rg.resource_group_name

  asp_kind = "Linux"

  app_service_plan_id = module.app_service_plan.app_service_plan_id


  application_insights_instrumentation_key = module.app_insights.application_insights_instrumentation_key
  application_insights_connection_string   = module.app_insights.application_insights_connection_string
  staging_slot_enabled                     = false

  site_config = {
    application_stack = {
      python_version = "3.9"
    }
  }

  app_settings = {
    foo   = "bar"
    stage = terraform.workspace
  }

  public_network_access_enabled = false

  app_service_vnet_integration_subnet_id = [local.subnet_id_out]
}

module "privateendpointlx" {

  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-privateendpoint"

  location            = module.rg.resource_group_location
  resource_group_name = module.rg.resource_group_name
  pe_name             = "${local.prefix_kebab}-${local.hash_suffix}-pendplx"
  subnet_id           = local.subnet_id
  target_resource     = module.app_service_linux.app_service_id

  subresource_names = ["sites"]
}

module "app_service_win" {
  source = "./../.." # Use the local version to test it

  app_service_name    = "${local.prefix_kebab}-${local.hash_suffix}-webw"
  location            = module.rgw.resource_group_location
  resource_group_name = module.rgw.resource_group_name
  os_type             = "Windows"
  app_service_plan_id = module.app_service_plan_w.app_service_plan_id


  application_insights_instrumentation_key = module.app_insights.application_insights_instrumentation_key
  application_insights_connection_string   = module.app_insights.application_insights_connection_string

  staging_slot_enabled = true

  site_config = {
    always_on          = true
    http2_enabled      = true
    websockets_enabled = true
    default_documents  = ["Default.htm", "Default.html", "Default.asp", "index.htm", "index.html", "iisstart.htm", "default.aspx", "index.php", "hostingstart.html"]

    application_stack = {
      current_stack  = "dotnet"
      dotnet_version = "v6.0"
    }
  }
  //NOT WORKING LX and WIN ASP in same VNET app_service_vnet_integration_subnet_id = [local.subnet_id_out]
  app_settings = {
    foo   = "bar"
    stage = terraform.workspace
  }

  public_network_access_enabled = false

}
module "privateendpointwin" {

  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-privateendpoint"

  location            = module.rgw.resource_group_location
  resource_group_name = module.rgw.resource_group_name
  pe_name             = "${local.prefix_kebab}-${local.hash_suffix}-pendpwin"
  subnet_id           = local.subnet_id
  target_resource     = module.app_service_win.app_service_windows.app_service_id

  subresource_names = ["sites"]
}

