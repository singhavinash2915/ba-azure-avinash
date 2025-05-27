output "application_insights_id" {
  description = " The ID of the Application Insights component."
  value       = azurerm_application_insights.app_insights.id
}
output "application_insights_app_id" {
  description = " The App ID associated with this Application Insights component."
  value       = azurerm_application_insights.app_insights.app_id
}
output "application_insights_instrumentation_key" {
  description = "Instrumentation key of the Application Insights associated to the App Service"
  value       = azurerm_application_insights.app_insights.instrumentation_key
  sensitive   = true
}
output "application_insights_connection_string" {
  description = "Connection string of the Application Insights associated to the App Service"
  value       = azurerm_application_insights.app_insights.connection_string
  sensitive   = true
}
# Log Analytics Workspace
output "log_analytics_workspace_id" {
  description = "The Log Analytics Workspace ID."
  value       = try(azurerm_log_analytics_workspace.la[0].id, null)
}
output "log_analytics_workspace_primary_shared_key" {
  description = "The Primary shared key for the Log Analytics Workspace."
  value       = try(azurerm_log_analytics_workspace.la[0].primary_shared_key, null)
  sensitive   = true
}
output "log_analytics_workspace_secondary_shared_key" {
  description = "The Secondary shared key for the Log Analytics Workspace."
  value       = try(azurerm_log_analytics_workspace.la[0].secondary_shared_key, null)
  sensitive   = true
}
# Storage Account
output "storage_account_id" {
  description = "The Storage Account ID."
  value       = try(azurerm_storage_account.logsa[0].id, null)
}
output "storage_account_name" {
  description = "The Storage Account Name."
  value       = try(azurerm_storage_account.logsa[0].name, null)
}
output "storage_account_primary_access_key" {
  description = "The Primary Access Key for the Storage Account."
  value       = try(azurerm_storage_account.logsa[0].primary_access_key, null)
  sensitive   = true
}
output "storage_account_secondary_access_key" {
  description = "The Secondary Access Key for the Storage Account."
  value       = try(azurerm_storage_account.logsa[0].secondary_access_key, null)
  sensitive   = true
}
output "storage_account_primary_connection_string" {
  description = "The Primary Connection String for the Storage Account."
  value       = try(azurerm_storage_account.logsa[0].primary_connection_string, null)
  sensitive   = true
}
output "storage_account_secondary_connection_string" {
  description = "The Secondary Connection String for the Storage Account."
  value       = try(azurerm_storage_account.logsa[0].secondary_connection_string, null)
  sensitive   = true
}