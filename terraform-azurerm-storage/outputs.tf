output "storage_id" {
  value       = azurerm_storage_account.main.id
  description = "The ID of the storage account."
}

output "storage_name" {
  value       = azurerm_storage_account.main.name
  description = "The name of the storage account."
}

output "storage_identity_principal_id" {
  description = "The Managed Service Identity."
  value       = try(azurerm_storage_account.main.identity.0.principal_id, null)
}

output "storage_primary_connection_string" {
  value       = azurerm_storage_account.main.primary_connection_string
  description = "The primary connection string for the storage account."
  sensitive   = true
}

output "storage_min_tls_version" {
  value       = azurerm_storage_account.main.min_tls_version
  description = "The minimum supported TLS version for the storage account."
}

output "storage_virtual_network_subnet_ids" {
  value       = (length(azurerm_storage_account_network_rules.storage_network_rules) > 0) ? [for a in azurerm_storage_account_network_rules.storage_network_rules : a.virtual_network_subnet_ids] : [["No subnets set"]]
  description = "The tupel of the subnet IDs."
}

output "storage_ip_rules" {
  value       = (length(azurerm_storage_account_network_rules.storage_network_rules) > 0) ? [for a in azurerm_storage_account_network_rules.storage_network_rules : a.ip_rules] : [["No ip rules set"]]
  description = "The IP list of public addresses having access to the storage account."
}

output "storage_primary_access_key" {
  value       = azurerm_storage_account.main.primary_access_key
  description = "The primary access key for the storage account."
  sensitive   = true
}

output "primary_blob_endpoint" {
  value       = azurerm_storage_account.main.primary_blob_endpoint
  description = "The endpoint URL for blob storage in the primary location."
}

output "primary_blob_connection_string" {
  value       = azurerm_storage_account.main.primary_blob_connection_string
  description = "The connection string associated with the primary blob location."
  sensitive   = true
}

output "storage_containers" {
  value = {
    for c in azurerm_storage_container.main :
    c.name => {
      id   = c.id
      name = c.name
    }
  }
  description = "Map of containers."
}

output "storage_shares" {
  value = { for s in azurerm_storage_share.main :
    s.name => {
      id   = s.id
      name = s.name
    }
  }
  description = "Map of shares."
}

output "storage_tables" {
  value       = { for t in azurerm_storage_table.main : t.name => t.id }
  description = "Map of tables."
}

output "storage_queues" {
  value       = { for t in azurerm_storage_queue.main : t.name => t.id }
  description = "Map of Queues."
}

output "static_website_enabled" {
  value       = var.static_website_enabled
  description = "Indicates whether the storage account activates static website hosting."
}
output "primary_web_endpoint" {
  value       = azurerm_storage_account.main.primary_web_endpoint
  description = "The endpoint URL for web storage in the primary location."
}
output "primary_web_host" {
  value       = azurerm_storage_account.main.primary_web_host
  description = "The hostname with port if applicable for web storage in the primary location."
}
output "secondary_web_endpoint" {
  value       = azurerm_storage_account.main.secondary_web_endpoint
  description = "The endpoint URL for web storage in the secondary location."
}
output "secondary_web_host" {
  value       = azurerm_storage_account.main.secondary_web_host
  description = "The hostname with port if applicable for web storage in the secondary location."
}