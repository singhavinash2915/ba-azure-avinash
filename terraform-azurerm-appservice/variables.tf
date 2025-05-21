variable "location" {
  description = "Azure location."
  type        = string
}

variable "app_service_name" {
  description = "AppService name"
  type        = string
}

variable "app_service_plan_id" {
  description = "AppService plan id"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "os_type" {
  description = "The O/S type for the App Services to be hosted in this plan. Possible values include `Windows`, `Linux`, and `Container`."
  type        = string
  default     = ""
}
variable "asp_kind" {
  description = "Kind of the App Service Plan that hosts the App Service, only for compatibility reasons"
  type        = string
  default     = ""
}
variable "application_insights_instrumentation_key" {
  description = "Instrumentaion key of the existing Application Insights to use."
  type        = string
  default     = null
}
variable "application_insights_connection_string" {
  description = "Connection string of the Application Insights to use."
  type        = string
  default     = null
}

variable "app_settings" {
  description = "Application settings for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#app_settings"
  type        = map(string)
  default     = {}
}

variable "site_config" {
  description = "Site config for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#site_config. IP restriction attribute is no more managed in this block."
  type        = any
  default     = {}
}

variable "connection_strings" {
  description = "Connection strings for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#connection_string"
  type        = list(map(string))
  default     = []
}

variable "identity_type" {
  description = "Add an Identity (MSI) to the App Service. Possible values are SystemAssigned or UserAssigned"
  type        = string
  default     = "SystemAssigned"
}

variable "identity_ids" {
  description = "UserAssigned Identities ID to add to App Service. Mandatory if type is UserAssigned"
  type        = list(string)
  default     = null
}
variable "key_vault_reference_identity_id" {
  description = "The User Assigned Identity Id used for looking up KeyVault secrets. The identity must be assigned to the application."
  type        = string
  default     = null
}

variable "authorized_ips" {
  description = "IPs restriction for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#ip_restriction"
  type        = list(string)
  default     = []
}

variable "authorized_subnet_ids" {
  description = "Subnets restriction for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#ip_restriction"
  type        = list(string)
  default     = []
}

variable "authorized_service_tags" {
  description = "Service Tags restriction for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#ip_restriction"
  type        = list(string)
  default     = []
}
variable "ip_restriction_default_action" {
  description = "The Default action for traffic that does not match any ip_restriction rule. possible values include Allow and Deny. Defaults to Allow."
  type        = string
  default     = "Allow"
}

variable "ip_restriction_headers" {
  description = "IPs restriction headers for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#headers"
  type        = map(list(string))
  default     = null
}

variable "scm_authorized_ips" {
  description = "SCM IPs restriction for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#scm_ip_restriction"
  type        = list(string)
  default     = []
}

variable "scm_authorized_subnet_ids" {
  description = "SCM subnets restriction for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#scm_ip_restriction"
  type        = list(string)
  default     = []
}

variable "scm_authorized_service_tags" {
  description = "SCM Service Tags restriction for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#scm_ip_restriction"
  type        = list(string)
  default     = []
}

variable "scm_ip_restriction_headers" {
  description = "IPs restriction headers for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#headers"
  type        = map(list(string))
  default     = null
}

variable "client_affinity_enabled" {
  description = "Client affinity activation for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#client_affinity_enabled"
  type        = bool
  default     = false
}

variable "https_only" {
  description = "HTTPS restriction for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#https_only"
  type        = bool
  default     = true
}

variable "client_certificate_enabled" {
  description = "Client certificate activation for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#client_certificate_enabled"
  type        = bool
  default     = false
}
variable "client_certificate_mode" {
  description = "(Optional) The Client Certificate mode. Possible values are `Required`, `Optional`, and `OptionalInteractiveUser`. This property has no effect when client_certificate_enabled is false."
  type        = string
  default     = null
}
variable "client_certificate_exclusion_paths" {
  description = "(Optional) Paths to exclude when using client certificates, separated by ;."
  type        = string
  default     = null
}

# Backup options

variable "backup_enabled" {
  description = "`true` to enable App Service backup"
  type        = bool
  default     = false
}

variable "backup_frequency_interval" {
  description = "Frequency interval for the App Service backup."
  type        = number
  default     = 1
}

variable "backup_retention_period_in_days" {
  description = "Retention in days for the App Service backup."
  type        = number
  default     = 30
}

variable "backup_frequency_unit" {
  description = "Frequency unit for the App Service backup. Possible values are `Day` or `Hour`."
  type        = string
  default     = "Day"
}

variable "backup_keep_at_least_one_backup" {
  description = "Should the service keep at least one backup, regardless of age of backup."
  type        = bool
  default     = true
}

variable "backup_storage_account_rg" {
  description = "Storage account resource group to use if App Service backup is enabled."
  type        = string
  default     = null
}

variable "backup_storage_account_name" {
  description = "Storage account name to use if App Service backup is enabled."
  type        = string
  default     = null
}

variable "backup_storage_account_container" {
  description = "Name of the container in the Storage Account if App Service backup is enabled"
  type        = string
  default     = "webapps"
}

variable "mount_points" {
  description = "Storage Account mount points. Name is generated if not set and default type is AzureFiles. See https://www.terraform.io/docs/providers/azurerm/r/app_service.html#storage_account"
  type        = list(map(string))
  default     = []
}

variable "auth_settings_v2" {
  description = "Authentication settings V2. See https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app#auth_settings_v2"
  type        = any
  default     = {}
}

variable "custom_domains" {
  description = "Custom domains and SSL certificates of the App Service. Could declare a custom domain with SSL binding. SSL certificate could be provided from an Azure Keyvault Certificate Secret or from a file."
  type        = map(map(string))
  default     = null
}


variable "app_service_vnet_integration_subnet_id" {
  description = "Id of the subnet to associate with the app service"
  type        = any
  default     = null
}

variable "staging_slot_enabled" {
  type        = bool
  description = "Create a staging slot alongside the app service for blue/green deployment purposes. See documentation https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_slot"
  default     = false
}

variable "staging_slot_custom_app_settings" {
  type        = map(string)
  description = "Override staging slot with custom app settings"
  default     = null
}

variable "staging_slot_custom_name" {
  type        = string
  description = "Custom name of the app service slot"
  default     = null
}

variable "backup_custom_name" {
  description = "Custom name for backup"
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to set on every taggable resources. Empty by default."
  type        = map(string)
  default     = {}
}

variable "docker_image" {
  description = "Docker image to use for this App Service"
  type = object({
    name = string
  })
  default = null
}
### compatibility Mode
variable "aad_client_id" {
  description = "This is the Client ID for the AzureAD Application to authenticate via AAD"
  type        = string
  default     = null
}
variable "allowed_audiences" {
  description = "allowed_audiences for  the AzureAD Application to authenticate via AAD"
  type        = list(string)
  default     = []
}
variable "application_insights_enabled" {
  description = "DOES NOT EFFECT ANYTHING Use Application Insights for this App Service"
  type        = bool
  default     = true
}
variable "authorized_x_azure_fdid" {
  description = "Frontdoor ID for Header Restriction"
  type        = list(string)
  default     = []
}
variable "custom_domains_azure" {
  description = "Custom domains and SSL certificates of the App Service. Could declare a custom domain with SSL binding. SSL certificate provided from Azure "
  type        = map(map(string))
  default     = null
}
variable "docker_registry_username" {
  type        = string
  default     = null
  description = "The container registry username."
}
variable "docker_registry_url" {
  type        = string
  default     = null
  description = "The container registry url."
}
variable "docker_registry_password" {
  type        = string
  default     = null
  description = "The container registry password."
}
variable "docker_port" {
  type        = string
  default     = "8080"
  description = "The value of the expected container port number."
}
variable "start_time_limit" {
  type        = number
  default     = 120
  description = "Configure the amount of time (in seconds) the app service will wait before it restarts the container. (max 230)"
}
variable "enable_storage" {
  type        = string
  default     = "false"
  description = "Mount an SMB share to the `/home/` directory."
}
variable "public_network_access_enabled" {
  type        = bool
  default     = true
  description = "Enables or disables the public network access"
}
variable "website_auth_encryption_key" {
  description = "The encryption key used for cookie encryption. See https://learn.microsoft.com/en-us/azure/app-service/reference-app-settings?tabs=kudu%2Cdotnet#authentication--authorization"
  type        = string
  default     = null
  sensitive   = true

}
variable "website_auth_signing_key" {
  description = "The signing key used for cookie signing. See https://learn.microsoft.com/en-us/azure/app-service/reference-app-settings?tabs=kudu%2Cdotnet#authentication--authorization"
  type        = string
  default     = null
  sensitive   = true
}

variable "webdeploy_publish_basic_authentication_enabled" {
  type        = bool
  default     = false
  description = "Should the default WebDeploy Basic Authentication publishing credentials enabled."
}

variable "ftp_publish_basic_authentication_enabled" {
  type        = bool
  default     = false
  description = "Should the default FTP Basic Authentication publishing profile be enabled."
}