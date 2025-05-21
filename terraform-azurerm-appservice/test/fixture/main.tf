module "app_service_container" {
  source = "./../.." # Use the local version to test it

  app_service_name                         = "${local.prefix_kebab}-${local.hash_suffix}-webcont"
  location                                 = module.rg.resource_group_location
  resource_group_name                      = module.rg.resource_group_name
  os_type                                  = "Container"
  app_service_plan_id                      = module.app_service_plan.app_service_plan_id
  application_insights_instrumentation_key = module.app_insights.application_insights_instrumentation_key
  application_insights_connection_string   = module.app_insights.application_insights_connection_string

  docker_image = {
    name = "helloworldcontainers/java-spring-boot-hello-world:latest"
  }

  site_config = {
  }
  app_service_vnet_integration_subnet_id = [module.vnet_lx.named_subnet_ids["subnet-backend"]]
  app_settings = {
    foo   = "bar"
    stage = terraform.workspace
  }
  authorized_x_azure_fdid = ["d128ffea-d08e-40b2-97b3-607820df0f01"]
  authorized_ips          = ["128.246.11.0/24"] # Special access from Gateway GPC Ludwigshafen
  authorized_subnet_ids   = [module.vnet_lx.named_subnet_ids["subnet-backend"]]
  authorized_service_tags = ["AzureFrontDoor.Backend"]

  depends_on = [module.vnet_lx]
}

module "app_service_linux" {
  source = "./../.." # Use the local version to test it

  app_service_name                         = "${local.prefix_kebab}-${local.hash_suffix}-weblx"
  location                                 = module.rg.resource_group_location
  resource_group_name                      = module.rg.resource_group_name
  os_type                                  = "Linux"
  app_service_plan_id                      = module.app_service_plan.app_service_plan_id
  application_insights_instrumentation_key = module.app_insights.application_insights_instrumentation_key
  application_insights_connection_string   = module.app_insights.application_insights_connection_string

  site_config = {
    application_stack = {
      python_version = "3.9"
    }
  }
  app_service_vnet_integration_subnet_id = [module.vnet_lx.named_subnet_ids["subnet-backend"]]
  app_settings = {
    foo   = "bar"
    stage = terraform.workspace
  }
  authorized_x_azure_fdid = ["d128ffea-d08e-40b2-97b3-607820df0f01"]
  authorized_ips          = ["128.246.11.0/24"] # Special access from Gateway GPC Ludwigshafen
  authorized_subnet_ids   = [module.vnet_lx.named_subnet_ids["subnet-backend"]]
  authorized_service_tags = ["AzureFrontDoor.Backend"]

  depends_on = [module.vnet_lx]
}

module "app_service_win" {
  source = "./../.." # Use the local version to test it

  app_service_name                         = "${local.prefix_kebab}-${local.hash_suffix}-webw"
  location                                 = module.rgw.resource_group_location
  resource_group_name                      = module.rgw.resource_group_name
  os_type                                  = "Windows"
  app_service_plan_id                      = module.app_service_plan_w.app_service_plan_id
  application_insights_instrumentation_key = module.app_insights.application_insights_instrumentation_key
  application_insights_connection_string   = module.app_insights.application_insights_connection_string

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
  app_service_vnet_integration_subnet_id = [module.vnet_win.named_subnet_ids["subnet-backend"]]

  app_settings = {
    foo   = "bar"
    stage = terraform.workspace
  }
  authorized_x_azure_fdid = ["d128ffea-d08e-40b2-97b3-607820df0f01"]
  authorized_ips          = ["128.246.11.0/24"] # Special access from Gateway GPC Ludwigshafen
  authorized_subnet_ids   = [module.vnet_win.named_subnet_ids["subnet-backend"]]
  authorized_service_tags = ["AzureFrontDoor.Backend"]

  depends_on = [module.vnet_win]

  client_certificate_enabled = true
  client_certificate_mode    = "Required"
  // not working with Tls 1.3 client_certificate_exclusion_paths = "*.ignore.basf.com;*.ignoremore.basf.com"
}

## EasyAuth V2 (auth_settings_v2)
module "app_service_linux_easyauth" {
  source = "./../.." # Use the local version to test it

  app_service_name                         = "${local.prefix_kebab}-${local.hash_suffix}-weblx-easyauth"
  location                                 = module.rg.resource_group_location
  resource_group_name                      = module.rg.resource_group_name
  os_type                                  = "Linux"
  app_service_plan_id                      = module.app_service_plan.app_service_plan_id
  application_insights_instrumentation_key = module.app_insights.application_insights_instrumentation_key
  application_insights_connection_string   = module.app_insights.application_insights_connection_string
  aad_client_id                            = "7f4d3e30-fada-4233-9494-77c8b6170cd4" //E2eTF-Test

  site_config = {
    application_stack = {
      python_version = "3.9"
    }
  }
  app_service_vnet_integration_subnet_id = [module.vnet_lx.named_subnet_ids["subnet-backend"]]
  app_settings = {
    foo                    = "bar"
    stage                  = terraform.workspace
    easyauthv2clientsecret = "secret"
  }

  depends_on = [module.vnet_lx]
}

module "app_service_container_easyauth" {
  source = "./../.." # Use the local version to test it

  app_service_name                         = "${local.prefix_kebab}-${local.hash_suffix}-webcont-easyauth"
  location                                 = module.rg.resource_group_location
  resource_group_name                      = module.rg.resource_group_name
  os_type                                  = "Container"
  app_service_plan_id                      = module.app_service_plan.app_service_plan_id
  application_insights_instrumentation_key = module.app_insights.application_insights_instrumentation_key
  application_insights_connection_string   = module.app_insights.application_insights_connection_string
  aad_client_id                            = "7f4d3e30-fada-4233-9494-77c8b6170cd4" //E2eTF-Test

  docker_image = {
    name = "helloworldcontainers/java-spring-boot-hello-world:latest"
  }

  site_config = {
  }

  app_service_vnet_integration_subnet_id = [module.vnet_lx.named_subnet_ids["subnet-backend"]]
  app_settings = {
    foo                    = "bar"
    stage                  = terraform.workspace
    easyauthv2clientsecret = "secret"
  }

  depends_on = [module.vnet_lx]
}

module "app_service_linux_easyauth_with_slots" {
  source = "./../.." # Use the local version to test it

  app_service_name                         = "${local.prefix_kebab}-${local.hash_suffix}-weblx-slots-easyauth"
  location                                 = module.rg.resource_group_location
  resource_group_name                      = module.rg.resource_group_name
  os_type                                  = "Linux"
  app_service_plan_id                      = module.app_service_plan.app_service_plan_id
  application_insights_instrumentation_key = module.app_insights.application_insights_instrumentation_key
  application_insights_connection_string   = module.app_insights.application_insights_connection_string
  staging_slot_enabled                     = true
  aad_client_id                            = "7f4d3e30-fada-4233-9494-77c8b6170cd4" //E2eTF-Test

  site_config = {
    application_stack = {
      python_version = "3.9"
    }
  }
  app_service_vnet_integration_subnet_id = [module.vnet_lx.named_subnet_ids["subnet-backend"]]
  app_settings = {
    foo                    = "bar"
    stage                  = terraform.workspace
    easyauthv2clientsecret = "secret"
  }

  depends_on = [module.vnet_lx]
}

module "app_service_win_easyauth" {
  source = "./../.." # Use the local version to test it

  app_service_name                         = "${local.prefix_kebab}-${local.hash_suffix}-webw-easyauth"
  location                                 = module.rgw.resource_group_location
  resource_group_name                      = module.rgw.resource_group_name
  os_type                                  = "Windows"
  app_service_plan_id                      = module.app_service_plan_w.app_service_plan_id
  application_insights_instrumentation_key = module.app_insights.application_insights_instrumentation_key
  application_insights_connection_string   = module.app_insights.application_insights_connection_string
  aad_client_id                            = "7f4d3e30-fada-4233-9494-77c8b6170cd4" //E2eTF-Test

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
  app_service_vnet_integration_subnet_id = [module.vnet_win.named_subnet_ids["subnet-backend"]]

  app_settings = {
    foo                    = "bar"
    stage                  = terraform.workspace
    easyauthv2clientsecret = "secret"
  }

  depends_on = [module.vnet_win]

}
