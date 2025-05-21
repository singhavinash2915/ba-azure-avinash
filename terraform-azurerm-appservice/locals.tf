//make Modules version compatible to older args
locals {
  os_type = var.os_type != "" ? var.os_type : var.asp_kind

  app_service_vnet_integration_subnet_id = try(tostring(element(var.app_service_vnet_integration_subnet_id, 1)), var.app_service_vnet_integration_subnet_id)
}