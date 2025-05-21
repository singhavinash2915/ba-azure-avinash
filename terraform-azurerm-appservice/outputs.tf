output "app_service_linux" {
  description = "App Service Linux (Linux WebApp) output object if Linux is choosen. Please refer to `./modules/linux-web-app/README.md`"
  value       = try(module.linux_web_app["enabled"], null)
  depends_on = [
    module.linux_web_app,
  ]
}

output "app_service_windows" {
  description = "App Service Windows (Windows WebApp) output object if Windows is choosen. Please refer to `./modules/windows-web-app/README.md`"
  value       = try(module.windows_web_app["enabled"], null)
  depends_on = [
    module.windows_web_app,
  ]
}
output "app_service_container" {
  description = "App Service Container (Linux WebApp) output object if Container is choosen. Please refer to `./modules/container-web-app/README.md`"
  value       = try(module.container_web_app["enabled"], null)
  depends_on = [
    module.container_web_app,
  ]
}

output "app_service" {
  value = try(module.linux_web_app["enabled"], null) != null ? module.linux_web_app["enabled"] : (try(module.windows_web_app["enabled"], null) != null ? module.windows_web_app["enabled"] : (try(module.container_web_app["enabled"], null) != null ? module.container_web_app["enabled"] : null))
  depends_on = [
    module.linux_web_app,
    module.container_web_app,
    module.windows_web_app,
  ]
}

locals {
  app_service = try(module.linux_web_app["enabled"], null) != null ? module.linux_web_app["enabled"] : (try(module.windows_web_app["enabled"], null) != null ? module.windows_web_app["enabled"] : (try(module.container_web_app["enabled"], null) != null ? module.container_web_app["enabled"] : null))
}

output "service_plan_id" {
  description = "ID of the Service Plan"
  value       = var.app_service_plan_id
  depends_on = [
    module.linux_web_app,
    module.container_web_app,
    module.windows_web_app,
  ]
}

output "app_service_id" {
  description = "Id of the App Service"
  value       = try(local.app_service.app_service_id, null)
  depends_on = [
    module.linux_web_app,
    module.container_web_app,
    module.windows_web_app,
  ]
}

output "id" {
  description = "Id of the App Service"
  value       = try(local.app_service.app_service_id, null)
  depends_on = [
    module.linux_web_app,
    module.container_web_app,
    module.windows_web_app,
  ]
}

output "app_service_name" {
  description = "Name of the App Service"
  value       = try(local.app_service.app_service_name, null)
  depends_on = [
    module.linux_web_app,
    module.container_web_app,
    module.windows_web_app,
  ]
}

output "name" {
  description = "Name of the App Service"
  value       = try(local.app_service.app_service_name, null)
  depends_on = [
    module.linux_web_app,
    module.container_web_app,
    module.windows_web_app,
  ]
}

output "app_service_default_site_hostname" {
  description = "The Default Hostname associated with the App Service"
  value       = try(local.app_service.app_service_default_site_hostname, null)
  depends_on = [
    module.linux_web_app,
    module.container_web_app,
    module.windows_web_app,
  ]
}

output "default_site_hostname" {
  description = "The Default Hostname associated with the App Service"
  value       = try(local.app_service.app_service_default_site_hostname, null)
  depends_on = [
    module.linux_web_app,
    module.container_web_app,
    module.windows_web_app,
  ]
}

output "app_service_outbound_ip_addresses" {
  description = "Outbound IP adresses of the App Service"
  value       = try(local.app_service.app_service_outbound_ip_addresses, null)
  depends_on = [
    module.linux_web_app,
    module.container_web_app,
    module.windows_web_app,
  ]
}

output "outbound_ip_addresses" {
  description = "Outbound IP adresses of the App Service"
  value       = try(local.app_service.app_service_outbound_ip_addresses, null)
  depends_on = [
    module.linux_web_app,
    module.container_web_app,
    module.windows_web_app,
  ]
}

output "app_service_possible_outbound_ip_addresses" {
  description = "Possible outbound IP adresses of the App Service"
  value       = try(local.app_service.app_service_possible_outbound_ip_addresses, null)
  depends_on = [
    module.linux_web_app,
    module.container_web_app,
    module.windows_web_app,
  ]
}

output "possible_outbound_ip_addresses" {
  description = "Possible outbound IP adresses of the App Service"
  value       = try(local.app_service.app_service_possible_outbound_ip_addresses, null)
  depends_on = [
    module.linux_web_app,
    module.container_web_app,
    module.windows_web_app,
  ]
}

output "app_service_site_credential" {
  description = "Site credential block of the App Service"
  value       = try(local.app_service.app_service_site_credential, null)
  depends_on = [
    module.linux_web_app,
    module.container_web_app,
    module.windows_web_app,
  ]
  sensitive = true
}

output "site_credential" {
  description = "Site credential block of the App Service"
  value       = try(local.app_service.app_service_site_credential, null)
  depends_on = [
    module.linux_web_app,
    module.container_web_app,
    module.windows_web_app,
  ]
  sensitive = true
}

output "app_service_identity_service_principal_id" {
  description = "Id of the Service principal identity of the App Service"
  value       = try(local.app_service.app_service_identity_service_principal_id, null)
  depends_on = [
    module.linux_web_app,
    module.container_web_app,
    module.windows_web_app,
  ]
}

output "identity_service_principal_id" {
  description = "Id of the Service principal identity of the App Service"
  value       = try(local.app_service.app_service_identity_service_principal_id, null)
  depends_on = [
    module.linux_web_app,
    module.container_web_app,
    module.windows_web_app,
  ]
}

output "app_service_slot_name" {
  description = "Name of the App Service slot"
  value       = try(local.app_service.app_service_slot_name, null)
  depends_on = [
    module.linux_web_app,
    module.container_web_app,
    module.windows_web_app,
  ]
}

output "slot_name" {
  description = "Name of the App Service slot"
  value       = try(local.app_service.app_service_slot_name, null)
  depends_on = [
    module.linux_web_app,
    module.container_web_app,
    module.windows_web_app,
  ]
}


output "app_service_slot_identity_service_principal_id" {
  description = "Id of the Service principal identity of the App Service slot"
  value       = try(local.app_service.app_service_slot_identity_service_principal_id, null)
  depends_on = [
    module.linux_web_app,
    module.container_web_app,
    module.windows_web_app,
  ]
}

output "slot_identity_service_principal_id" {
  description = "Id of the Service principal identity of the App Service slot"
  value       = try(local.app_service.app_service_slot_identity_service_principal_id, null)
  depends_on = [
    module.linux_web_app,
    module.container_web_app,
    module.windows_web_app,
  ]
}

output "app_service_public_network_access_enabled" {
  description = "Value of the public network access"
  value       = try(local.app_service.public_network_access_enabled, null)
  depends_on = [
    module.linux_web_app,
    module.container_web_app,
    module.windows_web_app,
  ]
}
output "app_service_custom_domain_verification_id" {
  description = "The identifier used by App Service to perform domain ownership verification via DNS TXT record."
  value       = try(local.app_service.app_service_custom_domain_verification_id, null)
  depends_on = [
    module.linux_web_app,
    module.container_web_app,
    module.windows_web_app,
  ]
}
output "website_auth_encryption_key" {
  description = "The encryption key used for cookie encryption. See https://learn.microsoft.com/en-us/azure/app-service/reference-app-settings?tabs=kudu%2Cdotnet#authentication--authorization"
  value       = try(local.app_service.website_auth_encryption_key, null)
  depends_on = [
    module.linux_web_app,
    module.container_web_app,
    module.windows_web_app,
  ]
}
output "website_auth_signing_key" {
  description = "The signing key used for cookie signing. See https://learn.microsoft.com/en-us/azure/app-service/reference-app-settings?tabs=kudu%2Cdotnet#authentication--authorization"
  value       = try(local.app_service.website_auth_signing_key, null)
  depends_on = [
    module.linux_web_app,
    module.container_web_app,
    module.windows_web_app,
  ]
}