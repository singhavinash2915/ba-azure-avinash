output "app_service_plan_id" {
  description = "Id of the created App Service Plan"
  value       = azurerm_service_plan.plan.id
}

output "app_service_plan_name" {
  description = "Name of the created App Service Plan"
  value       = azurerm_service_plan.plan.name
}

output "app_service_plan_location" {
  description = "Azure location of the created App Service Plan"
  value       = azurerm_service_plan.plan.location
}

output "app_service_plan_kind" {
  description = "Kind of App Service Plan"
  value       = azurerm_service_plan.plan.kind
}
