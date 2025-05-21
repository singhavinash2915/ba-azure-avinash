resource "azurerm_storage_account" "main" {
  name                     = var.name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_kind             = var.kind
  account_tier             = local.account_tier
  account_replication_type = local.account_replication_type

  access_tier                      = var.access_tier
  https_traffic_only_enabled       = var.https_only
  allow_nested_items_to_be_public  = var.allow_nested_items_to_be_public
  min_tls_version                  = var.min_tls_version
  tags                             = var.tags
  is_hns_enabled                   = var.is_hns_enabled
  nfsv3_enabled                    = var.nfsv3_enabled
  shared_access_key_enabled        = var.shared_access_key_enabled
  cross_tenant_replication_enabled = var.cross_tenant_replication_enabled


  identity {
    type = var.assign_identity ? "SystemAssigned" : null
  }

  dynamic "network_rules" {
    for_each = var.public_network_access_enabled == false && length(var.storage_vnet_integration_subnet_id) == 0 && length(var.storage_public_ip_list_allowed) == 0 ? ["network_rules"] : []
    content {
      default_action = "Deny"
      bypass         = ["AzureServices"]
    }
  }

  dynamic "static_website" {
    for_each = var.static_website_enabled == true ? ["static_website"] : []
    content {
      index_document     = var.static_website_index_document
      error_404_document = var.static_website_error_404_document
    }
  }

  dynamic "blob_properties" {
    for_each = var.blob_properties != null ? [var.blob_properties] : []
    content {
      dynamic "delete_retention_policy" {
        for_each = try(blob_properties.value["delete_retention_policy"], [])
        content {
          days = blob_properties.value["delete_retention_policy"].days
        }
      }
      dynamic "container_delete_retention_policy" {
        for_each = try(blob_properties.value["container_delete_retention_policy"], [])
        content {
          days = blob_properties.value["container_delete_retention_policy"].days
        }
      }
      dynamic "restore_policy" {
        for_each = try(blob_properties.value["restore_policy"], [])
        content {
          days = blob_properties.value["restore_policy"].days
        }
      }
      dynamic "cors_rule" {
        for_each = try(blob_properties.value["cors_rules"], [])
        content {
          allowed_headers    = cors_rule.value["allowed_headers"]
          allowed_methods    = cors_rule.value["allowed_methods"]
          allowed_origins    = cors_rule.value["allowed_origins"]
          exposed_headers    = cors_rule.value["exposed_headers"]
          max_age_in_seconds = cors_rule.value["max_age_in_seconds"]
        }
      }
      versioning_enabled            = try(blob_properties.value["versioning_enabled"], null)
      change_feed_enabled           = try(blob_properties.value["change_feed_enabled"], null)
      change_feed_retention_in_days = try(blob_properties.value["change_feed_retention_in_days"], null)
      default_service_version       = try(blob_properties.value["default_service_version"], null)
      last_access_time_enabled      = try(blob_properties.value["last_access_time_enabled"], null)
    }
  }
}

resource "azurerm_storage_account_network_rules" "storage_network_rules" {
  count                      = length(var.storage_vnet_integration_subnet_id) > 0 || length(var.storage_public_ip_list_allowed) > 0 ? 1 : 0
  storage_account_id         = azurerm_storage_account.main.id
  default_action             = var.default_action
  ip_rules                   = var.storage_public_ip_list_allowed
  virtual_network_subnet_ids = var.storage_vnet_integration_subnet_id
  bypass                     = ["Metrics", "AzureServices"]
}

resource "azurerm_storage_container" "main" {
  count                 = length(var.containers)
  name                  = var.containers[count.index].name
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = var.containers[count.index].access_type
}

resource "azurerm_storage_queue" "main" {
  count                = length(var.queues)
  name                 = var.queues[count.index]
  storage_account_name = azurerm_storage_account.main.name
}

resource "azurerm_storage_share" "main" {
  count                = length(var.shares)
  name                 = var.shares[count.index].name
  storage_account_name = azurerm_storage_account.main.name
  quota                = var.shares[count.index].quota
}

resource "azurerm_storage_table" "main" {
  count                = length(var.tables)
  name                 = var.tables[count.index]
  storage_account_name = azurerm_storage_account.main.name
}

resource "azurerm_storage_blob" "main" {
  count                  = length(local.blobs)
  name                   = local.blobs[count.index].name
  storage_account_name   = azurerm_storage_account.main.name
  storage_container_name = local.blobs[count.index].container_name
  type                   = local.blobs[count.index].type
  size                   = local.blobs[count.index].size
  content_type           = local.blobs[count.index].content_type
  source                 = local.blobs[count.index].source_file
  source_uri             = local.blobs[count.index].source_uri
  metadata               = local.blobs[count.index].metadata
  depends_on             = [azurerm_storage_container.main]
}
