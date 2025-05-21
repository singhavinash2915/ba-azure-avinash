# Azure App Service Web (Linux or Windows)

This Terraform module creates an [Azure App Service Web](https://docs.microsoft.com/en-us/azure/app-service/overview) (Linux or Windows)

## Limitations

* Diagnostics logs only works fine for Windows for now.
* Untested with App Service slots.
* Using a single certificate file on multiple domains with the `custom_domains` variable is not supported. Use a Key Vault certificate instead.
* Only one ASP Plan per VNET Integration is allowed


## Setup of App Service in IN Subscriptions
1.	If you need outbound connectivity of the App Service, e.g. to on-premise service or other Services in the Vnet, then order a 2nd Subnet, with the delegation to Microsoft.Web/serverFarms. 
This can be done via Service Now Request. In the future this will be a self service via SDDC
2.	Create your App Service in Azure, with the Private Endpoint and Vnet Integration, make sure that you Vnet is using 10.99.1.102 als nameserver. If the Vnet is peered in the US, adjust this
3.	Your App Service is now available inside the BASF Network under https://abc.azurewebsites.net. To make it available under a BASF Domain you have to request a CNAME via Service Now (GS0000424). Due to security restrictions, it’s only possible to order a abc.intranet.basf.com CNAME, because the CNAME must be resolvable by public DNS. So you have to order abc.intranet.basf.com pointing to abc.azurewebsites.com
4.  Order a TXT record to validate the Domain Ownership via [Service4you](https://service4you.intranet.basf.com/esc?id=sc_cat_item&table=sc_cat_item&sys_id=759ab1de973f61906e943a371153af8c). See here an [Example](https://docs.cloudreference.basf.com/CRI/certificates.html?tabs=azure#create-a-txt-record-via-servicenow-change-request-only-needed-when-using-easyauth)
5.	If the SubDomain is available, you can request a Microsoft hosted certificate
6.	From BASF Devices the Website is now available, from public devices it’s blocked.

# Examples
* implementation Examples are in the E2E test folders avaliable

<!-- BEGIN_TF_DOCS -->
## Usage

This module is optimized to work with the [BASF Terraform Runner](https://docs.cloudreference.basf.com/) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `BASF Terraform Runner` available in the [documentation](https://docs.cloudreference.basf.com/).

### Example usage PI  

```hcl
module "app_service_container" {
  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?ref=4.1" 

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
  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?ref=4.1" 

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
  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?ref=4.1" 

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
  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?ref=4.1" 

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
  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?ref=4.1" 

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
  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?ref=4.1" 

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
  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?ref=4.1" 

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
```

### Example usage IN  

```hcl
locals {
  # Subnet ID for the App Service Ingress Integration. This reflects you BCN connected vnet.
  subnet_id = "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/BASF_RG_Network_${data.azurerm_subscription.current.display_name}/providers/Microsoft.Network/virtualNetworks/BASF_VN_IN_${data.azurerm_subscription.current.display_name}/subnets/BASF_SN_IN_${data.azurerm_subscription.current.display_name}${var.subnet_intranet_name_suffix}"
  # Webapp Subnet id for the App Service VNet Integration. This reflects you BCN connected vnet.
  subnet_id_out = "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/BASF_RG_Network_${data.azurerm_subscription.current.display_name}/providers/Microsoft.Network/virtualNetworks/BASF_VN_IN_${data.azurerm_subscription.current.display_name}/subnets/BASF_SN_IN_${data.azurerm_subscription.current.display_name}${var.subnet_webapp_name_suffix}"
}
module "app_service_container" {
  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?ref=4.1" 

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
  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?ref=4.1" 

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
  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?ref=4.1" 

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

```

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| container\_web\_app | ./modules/container-web-app | n/a |
| linux\_web\_app | ./modules/linux-web-app | n/a |
| windows\_web\_app | ./modules/windows-web-app | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aad\_client\_id | This is the Client ID for the AzureAD Application to authenticate via AAD | `string` | `null` | no |
| allowed\_audiences | allowed\_audiences for  the AzureAD Application to authenticate via AAD | `list(string)` | `[]` | no |
| app\_service\_name | AppService name | `string` | n/a | yes |
| app\_service\_plan\_id | AppService plan id | `string` | n/a | yes |
| app\_service\_vnet\_integration\_subnet\_id | Id of the subnet to associate with the app service | `any` | `null` | no |
| app\_settings | Application settings for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#app_settings | `map(string)` | `{}` | no |
| application\_insights\_connection\_string | Connection string of the Application Insights to use. | `string` | `null` | no |
| application\_insights\_enabled | DOES NOT EFFECT ANYTHING Use Application Insights for this App Service | `bool` | `true` | no |
| application\_insights\_instrumentation\_key | Instrumentaion key of the existing Application Insights to use. | `string` | `null` | no |
| asp\_kind | Kind of the App Service Plan that hosts the App Service, only for compatibility reasons | `string` | `""` | no |
| auth\_settings\_v2 | Authentication settings V2. See https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app#auth_settings_v2 | `any` | `{}` | no |
| authorized\_ips | IPs restriction for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#ip_restriction | `list(string)` | `[]` | no |
| authorized\_service\_tags | Service Tags restriction for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#ip_restriction | `list(string)` | `[]` | no |
| authorized\_subnet\_ids | Subnets restriction for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#ip_restriction | `list(string)` | `[]` | no |
| authorized\_x\_azure\_fdid | Frontdoor ID for Header Restriction | `list(string)` | `[]` | no |
| backup\_custom\_name | Custom name for backup | `string` | `null` | no |
| backup\_enabled | `true` to enable App Service backup | `bool` | `false` | no |
| backup\_frequency\_interval | Frequency interval for the App Service backup. | `number` | `1` | no |
| backup\_frequency\_unit | Frequency unit for the App Service backup. Possible values are `Day` or `Hour`. | `string` | `"Day"` | no |
| backup\_keep\_at\_least\_one\_backup | Should the service keep at least one backup, regardless of age of backup. | `bool` | `true` | no |
| backup\_retention\_period\_in\_days | Retention in days for the App Service backup. | `number` | `30` | no |
| backup\_storage\_account\_container | Name of the container in the Storage Account if App Service backup is enabled | `string` | `"webapps"` | no |
| backup\_storage\_account\_name | Storage account name to use if App Service backup is enabled. | `string` | `null` | no |
| backup\_storage\_account\_rg | Storage account resource group to use if App Service backup is enabled. | `string` | `null` | no |
| client\_affinity\_enabled | Client affinity activation for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#client_affinity_enabled | `bool` | `false` | no |
| client\_certificate\_enabled | Client certificate activation for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#client_certificate_enabled | `bool` | `false` | no |
| client\_certificate\_exclusion\_paths | (Optional) Paths to exclude when using client certificates, separated by ;. | `string` | `null` | no |
| client\_certificate\_mode | (Optional) The Client Certificate mode. Possible values are `Required`, `Optional`, and `OptionalInteractiveUser`. This property has no effect when client\_certificate\_enabled is false. | `string` | `null` | no |
| connection\_strings | Connection strings for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#connection_string | `list(map(string))` | `[]` | no |
| custom\_domains | Custom domains and SSL certificates of the App Service. Could declare a custom domain with SSL binding. SSL certificate could be provided from an Azure Keyvault Certificate Secret or from a file. | `map(map(string))` | `null` | no |
| custom\_domains\_azure | Custom domains and SSL certificates of the App Service. Could declare a custom domain with SSL binding. SSL certificate provided from Azure | `map(map(string))` | `null` | no |
| docker\_image | Docker image to use for this App Service | <pre>object({<br/>    name = string<br/>  })</pre> | `null` | no |
| docker\_port | The value of the expected container port number. | `string` | `"8080"` | no |
| docker\_registry\_password | The container registry password. | `string` | `null` | no |
| docker\_registry\_url | The container registry url. | `string` | `null` | no |
| docker\_registry\_username | The container registry username. | `string` | `null` | no |
| enable\_storage | Mount an SMB share to the `/home/` directory. | `string` | `"false"` | no |
| ftp\_publish\_basic\_authentication\_enabled | Should the default FTP Basic Authentication publishing profile be enabled. | `bool` | `false` | no |
| https\_only | HTTPS restriction for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#https_only | `bool` | `true` | no |
| identity\_ids | UserAssigned Identities ID to add to App Service. Mandatory if type is UserAssigned | `list(string)` | `null` | no |
| identity\_type | Add an Identity (MSI) to the App Service. Possible values are SystemAssigned or UserAssigned | `string` | `"SystemAssigned"` | no |
| ip\_restriction\_default\_action | The Default action for traffic that does not match any ip\_restriction rule. possible values include Allow and Deny. Defaults to Allow. | `string` | `"Allow"` | no |
| ip\_restriction\_headers | IPs restriction headers for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#headers | `map(list(string))` | `null` | no |
| key\_vault\_reference\_identity\_id | The User Assigned Identity Id used for looking up KeyVault secrets. The identity must be assigned to the application. | `string` | `null` | no |
| location | Azure location. | `string` | n/a | yes |
| mount\_points | Storage Account mount points. Name is generated if not set and default type is AzureFiles. See https://www.terraform.io/docs/providers/azurerm/r/app_service.html#storage_account | `list(map(string))` | `[]` | no |
| os\_type | The O/S type for the App Services to be hosted in this plan. Possible values include `Windows`, `Linux`, and `Container`. | `string` | `""` | no |
| public\_network\_access\_enabled | Enables or disables the public network access | `bool` | `true` | no |
| resource\_group\_name | Resource group name | `string` | n/a | yes |
| scm\_authorized\_ips | SCM IPs restriction for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#scm_ip_restriction | `list(string)` | `[]` | no |
| scm\_authorized\_service\_tags | SCM Service Tags restriction for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#scm_ip_restriction | `list(string)` | `[]` | no |
| scm\_authorized\_subnet\_ids | SCM subnets restriction for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#scm_ip_restriction | `list(string)` | `[]` | no |
| scm\_ip\_restriction\_headers | IPs restriction headers for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#headers | `map(list(string))` | `null` | no |
| site\_config | Site config for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#site_config. IP restriction attribute is no more managed in this block. | `any` | `{}` | no |
| staging\_slot\_custom\_app\_settings | Override staging slot with custom app settings | `map(string)` | `null` | no |
| staging\_slot\_custom\_name | Custom name of the app service slot | `string` | `null` | no |
| staging\_slot\_enabled | Create a staging slot alongside the app service for blue/green deployment purposes. See documentation https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_slot | `bool` | `false` | no |
| start\_time\_limit | Configure the amount of time (in seconds) the app service will wait before it restarts the container. (max 230) | `number` | `120` | no |
| tags | A map of tags to set on every taggable resources. Empty by default. | `map(string)` | `{}` | no |
| webdeploy\_publish\_basic\_authentication\_enabled | Should the default WebDeploy Basic Authentication publishing credentials enabled. | `bool` | `false` | no |
| website\_auth\_encryption\_key | The encryption key used for cookie encryption. See https://learn.microsoft.com/en-us/azure/app-service/reference-app-settings?tabs=kudu%2Cdotnet#authentication--authorization | `string` | `null` | no |
| website\_auth\_signing\_key | The signing key used for cookie signing. See https://learn.microsoft.com/en-us/azure/app-service/reference-app-settings?tabs=kudu%2Cdotnet#authentication--authorization | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| app\_service | n/a |
| app\_service\_container | App Service Container (Linux WebApp) output object if Container is choosen. Please refer to `./modules/container-web-app/README.md` |
| app\_service\_custom\_domain\_verification\_id | The identifier used by App Service to perform domain ownership verification via DNS TXT record. |
| app\_service\_default\_site\_hostname | The Default Hostname associated with the App Service |
| app\_service\_id | Id of the App Service |
| app\_service\_identity\_service\_principal\_id | Id of the Service principal identity of the App Service |
| app\_service\_linux | App Service Linux (Linux WebApp) output object if Linux is choosen. Please refer to `./modules/linux-web-app/README.md` |
| app\_service\_name | Name of the App Service |
| app\_service\_outbound\_ip\_addresses | Outbound IP adresses of the App Service |
| app\_service\_possible\_outbound\_ip\_addresses | Possible outbound IP adresses of the App Service |
| app\_service\_public\_network\_access\_enabled | Value of the public network access |
| app\_service\_site\_credential | Site credential block of the App Service |
| app\_service\_slot\_identity\_service\_principal\_id | Id of the Service principal identity of the App Service slot |
| app\_service\_slot\_name | Name of the App Service slot |
| app\_service\_windows | App Service Windows (Windows WebApp) output object if Windows is choosen. Please refer to `./modules/windows-web-app/README.md` |
| default\_site\_hostname | The Default Hostname associated with the App Service |
| id | Id of the App Service |
| identity\_service\_principal\_id | Id of the Service principal identity of the App Service |
| name | Name of the App Service |
| outbound\_ip\_addresses | Outbound IP adresses of the App Service |
| possible\_outbound\_ip\_addresses | Possible outbound IP adresses of the App Service |
| service\_plan\_id | ID of the Service Plan |
| site\_credential | Site credential block of the App Service |
| slot\_identity\_service\_principal\_id | Id of the Service principal identity of the App Service slot |
| slot\_name | Name of the App Service slot |
| website\_auth\_encryption\_key | The encryption key used for cookie encryption. See https://learn.microsoft.com/en-us/azure/app-service/reference-app-settings?tabs=kudu%2Cdotnet#authentication--authorization |
| website\_auth\_signing\_key | The signing key used for cookie signing. See https://learn.microsoft.com/en-us/azure/app-service/reference-app-settings?tabs=kudu%2Cdotnet#authentication--authorization |

# Change log
## terraform-azurerm-appservice Changelog
---
### [4.1](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT4.1)

#### [4.1.22370](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT4.1.22370) <small>(2025-02-03 by Felix Brettnich)</small>
Added support for WebDeploy and FTP Basic Authentication options

#### Summary
Added support for WebDeploy and FTP Basic Authentication options

#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| => 0.14          | ~>4.0                            |

---
### [4.0](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT4.0)

#### [4.0.22140](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT4.0.22140) <small>(2025-01-28 by Felix Brettnich)</small>
Fixed cors config

#### Summary
Fixed cors config

#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| >= 0.14          | ~>4.0                            |


#### [4.0.22013](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT4.0.22013) <small>(2025-01-24 by Felix Brettnich)</small>
Fixed auth settings

#### Summary
Fixed auth settings

#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| >= 0.14          | ~>4.0                            |


#### [4.0.21988](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT4.0.21988) <small>(2025-01-21 by Michael Kroh)</small>
update min_tls_version to 1.3

#### Summary
update min_tls_version to 1.3

Breaking
 * client_certificate_exclusion_path is not longer supported with Tls 1.3

Changed
  * update min_tls_version to 1.3


#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| => 0.14          | ~>4.0                            |




#### [4.0.21180](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT4.0.21180) <small>(2024-12-09 by Michael Kroh)</small>
fix e2e tests with sensitive values

#### Summary
fix e2e tests with sensitive values


#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| => 0.14          | ~>4.0                            |




#### [4.0.20472](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT4.0.20472) <small>(2024-11-13)</small>
_No description provided._

---
### [2.8](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.8)

#### [2.8.20293](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.8.20293) <small>(2024-11-09 by Michael Kroh)</small>
fix Firstwave E2E

#### Summary
fix Firstwave E2E


#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| => 0.14.x          | ~>4.0                            |



#### [2.8.20090](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.8.20090) <small>(2024-11-07 by Michael Kroh)</small>
Update to azurerm4

#### Summary
Update to azurerm4

Breaking
  * Update to azurerm4

#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| => 0.14          | >3.45                          |

---
### [2.7](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.7)

#### [2.7.19349](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.7.19349) <small>(2024-10-10)</small>
_No description provided._


#### [2.7.17169](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.7.17169) <small>(2024-07-13 by Martin Fabian)</small>
Added possibillity to adjust environment which variables are related to App Service authentication

#### Summary

Added possibillity to adjust environment variables which are related to App Service authentication

Changed
Added variables and outputs for: 
WEBSITE_AUTH_ENCRYPTION_KEY
By default, the automatically generated key is used as the encryption key. To override, set to a desired key. This is recommended if you want to share tokens or sessions across multiple apps. If specified, it supersedes the MACHINEKEY_DecryptionKey setting.

WEBSITE_AUTH_SIGNING_KEY
By default, the automatically generated key is used as the signing key. To override, set to a desired key. This is recommended if you want to share tokens or sessions across multiple apps. If specified, it supersedes the MACHINEKEY_ValidationKey setting.

See: https://learn.microsoft.com/en-us/azure/app-service/reference-app-settings?tabs=kudu%2Cdotnet#authentication--authorization

#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| > 0.14.x          | ~> 3.45                            |

---
### [2.6](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.6)

#### [2.6.16590](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.6.16590) <small>(2024-06-19 by Michael Kroh)</small>
add ip_restriction_default_action

#### Summary
add ip_restriction_default_action



Changed
  * add ip_restriction_default_action



#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| > 0.14.x          | >= 3.66                            |



---
### [2.5](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.5)

#### [2.5.16585](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.5.16585) <small>(2024-06-19 by Felix Brettnich)</small>
Added default_ip_restrictions_deny

#### Summary
https://github.com/hashicorp/terraform-provider-azurerm/issues/22593

Fixed
  * Default ip_restrictions action

#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| >= 0.14.x          | ~> 3.45                            |


#### [2.5.16573](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.5.16573) <small>(2024-06-19 by Michael Kroh)</small>
pin version to <3.95 to avoid https://github.com/hashicorp/terraform-provider...

#### Summary
pin version to < 3.95 to avoid https://github.com/hashicorp/terraform-provider...

Fixed
  * pin version to < 3.95 to avoid https://github.com/hashicorp/terraform-provider...

#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| > 0.14.x          | < 3.95                         |




#### [2.5.15086](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.5.15086) <small>(2024-04-19 by Martin Fabian)</small>
Process Parameter allowed_audiences correctly

#### Summary
Process Parameter allowed_audiences correctly

Fixed
  * the parmater allowed_audiences is now handled correctly for EasyAuth-V2

#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| > 0.14.x          | ~> 3.46                            |


#### [2.5.13054](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.5.13054) <small>(2024-01-09 by Michael Kroh)</small>
implement health_check_eviction_time_in_min

#### Summary
implement health_check_eviction_time_in_min



Changed
  * health_check_eviction_time_in_min - (Optional) The amount of time in minutes that a node can be unhealthy before being removed from the load balancer. Possible values are between 2 and 10. Only valid in conjunction with health_check_path.


#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| > 0.14.x          | >= 3.66                            |




#### [2.5.11733](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.5.11733) <small>(2023-11-07 by Martin Fabian)</small>
EasyAuthV2 implementation with not EasyAuhtV1 support anymore

#### Summary
Only EasyAuthV2 via variable aad_client_id 

Breaking
  * No EasyAuthV1 anymore supported by module. Only auth_settings_v2 are now passed to submodules -> auth_settings parameter anymore available.


#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| > 0.14.x          | >= 3.45                            |


#### [2.5.11457](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.5.11457) <small>(2023-10-24 by Martin Fabian)</small>
Added Auth_Settings_V2 (EasyAuthV2) to AppService

#### Summary
Added Auth_Settings_V2 capability to AppService

Changed
  * Added Auth_Settings_V2 settings. See https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app#auth_settings_v2 and https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_web_app#auth_settings_v2

#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| > 0.14.x          | >= 3.45                            |

---
### [2.4](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.4)

#### [2.4.11342](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.4.11342) <small>(2023-10-20 by Michael Kroh)</small>
Implement client_certificate_exclusion_paths

#### Summary
Implement client_certificate_exclusion_paths
Changed
  * Implement client_certificate_exclusion_paths


#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| > 0.14.x          | >= 3.66                            |

impelement client_certificate_exclusion_paths


#### [2.4.11324](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.4.11324) <small>(2023-10-17 by Michael Kroh)</small>
Fixing ip_restrictions changes

#### Summary
Fixing ip_restriction changes


Changed
  * added client_certificate_mode parameter

Fixed
  * fixes lifecycle block, that e.g. ip_restriction changes are discovered

#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| > 0.14.x          | >= 3.66                            |


#### [2.4.11115](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.4.11115) <small>(2023-10-06 by Michael Kroh)</small>
Add custom Domain Verification ID

#### Summary
- Add custom Domain Verification ID to outputs

#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| > 0.14.x          | >= 3.66                            |


#### [2.4.11088](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.4.11088) <small>(2023-10-05 by Daniel Schmitt)</small>
Fixed public network access 

#### Summary
* Added new variable for public network access which was introduces by HashiCorp to enable or disable public network access
* Fixed AppService deprecated arguments

#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| > 0.14.x          | >= 3.66                            |

---
### [2.3](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.3)

#### [2.3.10398](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.3.10398) <small>(2023-08-24)</small>
_No description provided._


#### [2.3.10373](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.3.10373) <small>(2023-08-23)</small>
_No description provided._


#### [2.3.10346](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.3.10346) <small>(2023-08-21 by Martin Fabian)</small>
Chages for Terraform-Docs

#### Summary
Added Terraform-Docs-Section in Readme.md and re-arranged e2e-test for including fixture/main.tf in Readme.md via terraform-docs

#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| > 0.14.x          | >= 3.66                            |


#### [2.3.10167](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.3.10167) <small>(2023-08-14 by Michael Kroh)</small>
add app insights settings for Windows ASP

#### Summary
add app insights settings for Windows ASP

Changed
  * add app insights settings for Windows ASP



#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| > 0.14.x          | >= 3.66                            |


#### [2.3.10161](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.3.10161) <small>(2023-08-14 by Michael Kroh)</small>
Fix  key_vault_reference_identity_id

#### Summary
key_vault_reference_identity_id was mssing in main

Fixed
  * key_vault_reference_identity_id was mssing in main

#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| > 0.14.x          | >= 3.66                            |



#### [2.3.9751](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.3.9751) <small>(2023-07-28 by Felix Brettnich)</small>
Added pull request template

#### Summary
Added pull request template


# Contributing

When contributing to this repository, please first discuss the change you wish to make via issue,
email, or any other method with the owners of this repository before making a change. 

Please note we have a code of conduct, please follow it in all your interactions with the project.

## Pull Request Process

1. Ensure any install or build dependencies are removed before the end of the layer when doing a 
  build.
2. Update the README.md with details of changes to the interface, this includes new environment 
  variables, exposed ports, useful file locations and container parameters.
3. Increase the version numbers in any examples files and the README.md to the new version that this
  Pull Request would represent. The versioning scheme we use is [SemVer](http://semver.org/).
4. You may merge the Pull Request in once you have the sign-off of two other developers, or if you 
  do not have permission to do that, you may request the second reviewer to merge it for you.

## Code of Conduct

### Our Pledge

In the interest of fostering an open and welcoming environment, we as
contributors and maintainers pledge to making participation in our project and
our community a harassment-free experience for everyone, regardless of age, body
size, disability, ethnicity, gender identity and expression, level of experience,
nationality, personal appearance, race, religion, or sexual identity and
orientation.

### Our Standards

Examples of behavior that contributes to creating a positive environment
include:

* Using welcoming and inclusive language
* Being respectful of differing viewpoints and experiences
* Gracefully accepting constructive criticism
* Focusing on what is best for the community
* Showing empathy towards other community members

Examples of unacceptable behavior by participants include:

* The use of sexualized language or imagery and unwelcome sexual attention or
advances
* Trolling, insulting/derogatory comments, and personal or political attacks
* Public or private harassment
* Publishing others' private information, such as a physical or electronic
  address, without explicit permission
* Other conduct which could reasonably be considered inappropriate in a
  professional setting

### Our Responsibilities

Project maintainers are responsible for clarifying the standards of acceptable
behavior and are expected to take appropriate and fair corrective action in
response to any instances of unacceptable behavior.

Project maintainers have the right and responsibility to remove, edit, or
reject comments, commits, code, wiki edits, issues, and other contributions
that are not aligned to this Code of Conduct, or to ban temporarily or
permanently any contributor for other behaviors that they deem inappropriate,
threatening, offensive, or harmful.

### Scope

This Code of Conduct applies both within project spaces and in public spaces
when an individual is representing the project or its community. Examples of
representing a project or community include using an official project e-mail
address, posting via an official social media account, or acting as an appointed
representative at an online or offline event. Representation of a project may be
further defined and clarified by project maintainers.

### Enforcement

Instances of abusive, harassing, or otherwise unacceptable behavior may be
reported by contacting the project team at [cloud-at-basf@basf.com]. All
complaints will be reviewed and investigated and will result in a response that
is deemed necessary and appropriate to the circumstances. The project team is
obligated to maintain confidentiality with regard to the reporter of an incident.
Further details of specific enforcement policies may be posted separately.

Project maintainers who do not follow or enforce the Code of Conduct in good
faith may face temporary or permanent repercussions as determined by other
members of the project's leadership.

### Attribution

This Code of Conduct is adapted from the [Contributor Covenant][homepage], version 1.4,
available at [http://contributor-covenant.org/version/1/4][version]

[homepage]: http://contributor-covenant.org
[version]: http://contributor-covenant.org/version/1/4/
<!-- END_TF_DOCS -->

## Additional Information
### Related documentation
Microsoft Azure documentation: [docs.microsoft.com/en-us/azure/app-service/overview](https://docs.microsoft.com/en-us/azure/app-service/overview)

### Links
- [Terraform Azure Provider Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [azurerm_linux_web_app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app)
- [azurerm_windows_web_app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_web_app)
- [Microsoft Azure documentation: docs.microsoft.com/en-us/azure/app-service/overview](https://docs.microsoft.com/en-us/azure/app-service/overview)

   
