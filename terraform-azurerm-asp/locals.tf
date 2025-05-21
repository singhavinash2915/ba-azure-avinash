//make Modules version compatible to older azurerm azurerm_app_service_plan
locals {

  os  = var.os_type != "" ? var.os_type : var.kind
  sku = var.sku_name != "" ? var.sku_name : lookup(var.sku, "size", null)

}
