resource "azurerm_log_analytics_workspace" "la" {
  count               = var.createloganalytigsworkspace ? 1 : 0
  name                = local.log_analytics_workspace_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  retention_in_days   = var.retention_in_days
}

resource "azurerm_storage_account" "logsa" {
  count                    = var.createstorageaccount ? 1 : 0
  name                     = local.storage_account_name
  location                 = var.location
  resource_group_name      = var.resource_group_name
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type
}

resource "azurerm_application_insights" "app_insights" {
  name                = local.app_insights_name
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = var.application_type
  workspace_id        = var.createloganalytigsworkspace ? azurerm_log_analytics_workspace.la[0].id : null

  # ToDo: Check if still needed
  # tags = merge(
  #   var.tags,
  #   {
  #     format("hidden-link:%s", local.app_service_id) = "Resource"
  #   },
  # )

}
