output "app_service_plan_id" {
  description = "Id of the created App Service Plan"
  value       = module.app_service_plan.app_service_plan_id
}
output "app_service_plancomp_id" {
  description = "Id of the created App Service Plan"
  value       = module.app_service_plancomp.app_service_plan_id
}

output "app_service_plan_name" {
  description = "Name of the created App Service Plan"
  value       = module.app_service_plan.app_service_plan_name
}

output "app_service_plan_location" {
  description = "Azure location of the created App Service Plan"
  value       = module.app_service_plan.app_service_plan_location
}

output "app_service_plan_kind" {
  description = "Kind of App Service Plan"
  value       = module.app_service_plan.app_service_plan_kind
}

output "app_service_plancomp_kind" {
  description = "Kind of App Service Plan Compatibility"
  value       = module.app_service_plancomp.app_service_plan_kind
}