# Log Analytics Workspace
output "application_insights_id" {
  description = "The ID of the Application Insights component."
  value       = module.app_insights.application_insights_id
}
output "application_insights_app_id" {
  description = "The App ID associated with this Application Insights component."
  value       = module.app_insights.application_insights_app_id
}
output "application_insights_instrumentation_key" {
  description = "Instrumentation key of the Application Insights associated to the App Service"
  value       = module.app_insights.application_insights_instrumentation_key
  sensitive   = true
}
output "application_insights_connection_string" {
  description = "Connection string of the Application Insights associated to the App Service"
  value       = module.app_insights.application_insights_connection_string
  sensitive   = true
}
output "log_analytics_workspace_id" {
  description = "The Log Analytics Workspace ID."
  value       = module.app_insights.log_analytics_workspace_id
}
output "log_analytics_workspace_primary_shared_key" {
  description = "The Primary shared key for the Log Analytics Workspace."
  value       = module.app_insights.log_analytics_workspace_primary_shared_key
  sensitive   = true
}
output "log_analytics_workspace_secondary_shared_key" {
  description = "The Secondary shared key for the Log Analytics Workspace."
  value       = module.app_insights.log_analytics_workspace_secondary_shared_key
  sensitive   = true
}

output "app_insights_azurerm_monitor_diagnostic_setting" {
  description = "The ID of the Diagnostic Setting for the Application Insights component."
  value       = azurerm_monitor_diagnostic_setting.app_insights_azurerm_monitor_diagnostic_setting.id
}

# Storage Account
output "application_insights_id_sa" {
  description = "The ID of the Application Insights component."
  value       = module.app_insights_sa.application_insights_id
}
output "application_insights_app_id_sa" {
  description = "The App ID associated with this Application Insights component."
  value       = module.app_insights_sa.application_insights_app_id
}
output "application_insights_instrumentation_key_sa" {
  description = "Instrumentation key of the Application Insights associated to the App Service"
  value       = module.app_insights_sa.application_insights_instrumentation_key
  sensitive   = true
}
output "application_insights_connection_string_sa" {
  description = "Connection string of the Application Insights associated to the App Service"
  value       = module.app_insights_sa.application_insights_connection_string
  sensitive   = true
}

output "storage_account_id_sa" {
  description = "The Storage Account ID."
  value       = module.app_insights_sa.storage_account_id
}

output "storage_account_name_sa" {
  description = "The Storage Account Name."
  value       = module.app_insights_sa.storage_account_name
}

output "app_insights_sa_azurerm_monitor_diagnostic_setting" {
  description = "The ID of the Diagnostic Setting for the Application Insights component."
  value       = azurerm_monitor_diagnostic_setting.app_insights_sa_azurerm_monitor_diagnostic_setting.id
}
