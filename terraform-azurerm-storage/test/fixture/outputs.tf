output "storage_id" {
  value       = module.storage.storage_id
  description = "The ID of the storage account."
}

output "storage_name" {
  value       = module.storage.storage_name
  description = "The name of the storage account."
}

output "storage_identity_principal_id" {
  value       = try(module.storage.storage_identity_principal_id, null)
  description = "The Managed Service Identity."
}

output "storage_primary_connection_string" {
  value       = module.storage.storage_primary_connection_string
  description = "The primary connection string for the storage account."
  sensitive   = true

}

output "storage_virtual_network_subnet_ids" {
  value       = module.storage.storage_virtual_network_subnet_ids
  description = "The tupel of the subnet IDs."
}

output "storage_min_tls_version" {
  value       = module.storage.storage_min_tls_version
  description = "The minimum supported TLS version for the storage account."
}

output "storage_ip_rules" {
  value       = module.storage.storage_ip_rules
  description = "The IP list of public addresses having access to the storage account."
}

output "storage_primary_access_key" {
  value       = module.storage.storage_primary_access_key
  description = "The primary access key for the storage account."
  sensitive   = true
}

output "primary_blob_endpoint" {
  value       = module.storage.primary_blob_endpoint
  description = "The endpoint URL for blob storage in the primary location."
}

output "primary_blob_connection_string" {
  value       = module.storage.primary_blob_connection_string
  description = " The connection string associated with the primary blob location."
  sensitive   = true
}


## Static Website LRS
output "storage_id_staticwebsite" {
  value       = module.storagestaticwebsite.storage_id
  description = "The ID of the storage account."
}

output "storage_name_staticwebsite" {
  value       = module.storagestaticwebsite.storage_name
  description = "The name of the storage account."
}

output "storage_identity_principal_id_staticwebsite" {
  value       = try(module.storagestaticwebsite.storage_identity_principal_id, null)
  description = "The Managed Service Identity."
}

output "storage_primary_connection_string_staticwebsite" {
  value       = module.storagestaticwebsite.storage_primary_connection_string
  description = "The primary connection string for the storage account."
  sensitive   = true
}

output "storage_virtual_network_subnet_ids_staticwebsite" {
  value       = module.storagestaticwebsite.storage_virtual_network_subnet_ids
  description = "The tupel of the subnet IDs."
}

output "storage_min_tls_version_staticwebsite" {
  value       = module.storagestaticwebsite.storage_min_tls_version
  description = "The minimum supported TLS version for the storage account."
}

output "storage_ip_rules_staticwebsite" {
  value       = module.storagestaticwebsite.storage_ip_rules
  description = "The IP list of public addresses having access to the storage account."
}

output "storage_primary_access_key_staticwebsite" {
  value       = module.storagestaticwebsite.storage_primary_access_key
  description = "The primary access key for the storage account."
  sensitive   = true
}

output "primary_blob_endpoint_staticwebsite" {
  value       = module.storagestaticwebsite.primary_blob_endpoint
  description = "The endpoint URL for blob storage in the primary location."

}

output "primary_blob_connection_string_staticwebsite" {
  value       = module.storagestaticwebsite.primary_blob_connection_string
  description = " The connection string associated with the primary blob location."
  sensitive   = true
}

output "static_website_enabled_staticwebsite" {
  value       = module.storagestaticwebsite.static_website_enabled
  description = "Indicates whether the storage account activates static website hosting."
}
output "primary_web_endpoint_staticwebsite" {
  value       = module.storagestaticwebsite.primary_web_endpoint
  description = "The endpoint URL for web storage in the primary location."
}
output "primary_web_host_staticwebsite" {
  value       = module.storagestaticwebsite.primary_web_host
  description = "The hostname with port if applicable for web storage in the primary location."
}
output "secondary_web_endpoint_staticwebsite" {
  value       = module.storagestaticwebsite.secondary_web_endpoint
  description = "The endpoint URL for web storage in the secondary location."
}
output "secondary_web_host_staticwebsite" {
  value       = module.storagestaticwebsite.secondary_web_host
  description = "The hostname with port if applicable for web storage in the secondary location."
}


## Static Website RAGRS
output "storage_id_staticwebsiteRAGRS" {
  value       = module.storagestaticwebsiteRAGRS.storage_id
  description = "The ID of the storage account."
}

output "storage_name_staticwebsiteRAGRS" {
  value       = module.storagestaticwebsiteRAGRS.storage_name
  description = "The name of the storage account."
}

output "storage_identity_principal_id_staticwebsiteRAGRS" {
  value       = try(module.storagestaticwebsiteRAGRS.storage_identity_principal_id, null)
  description = "The Managed Service Identity."
}

output "storage_primary_connection_string_staticwebsiteRAGRS" {
  value       = module.storagestaticwebsiteRAGRS.storage_primary_connection_string
  description = "The primary connection string for the storage account."
  sensitive   = true
}

output "storage_virtual_network_subnet_ids_staticwebsiteRAGRS" {
  value       = module.storagestaticwebsiteRAGRS.storage_virtual_network_subnet_ids
  description = "The tupel of the subnet IDs."
}

output "storage_min_tls_version_staticwebsiteRAGRS" {
  value       = module.storagestaticwebsiteRAGRS.storage_min_tls_version
  description = "The minimum supported TLS version for the storage account."
}

output "storage_ip_rules_staticwebsiteRAGRS" {
  value       = module.storagestaticwebsiteRAGRS.storage_ip_rules
  description = "The IP list of public addresses having access to the storage account."
}

output "storage_primary_access_key_staticwebsiteRAGRS" {
  value       = module.storagestaticwebsiteRAGRS.storage_primary_access_key
  description = "The primary access key for the storage account."
  sensitive   = true
}

output "primary_blob_endpoint_staticwebsiteRAGRS" {
  value       = module.storagestaticwebsiteRAGRS.primary_blob_endpoint
  description = "The endpoint URL for blob storage in the primary location."

}

output "primary_blob_connection_string_staticwebsiteRAGRS" {
  value       = module.storagestaticwebsiteRAGRS.primary_blob_connection_string
  description = " The connection string associated with the primary blob location."
  sensitive   = true
}

output "static_website_enabled_staticwebsiteRAGRS" {
  value       = module.storagestaticwebsiteRAGRS.static_website_enabled
  description = "Indicates whether the storage account activates static website hosting."
}
output "primary_web_endpoint_staticwebsiteRAGRS" {
  value       = module.storagestaticwebsiteRAGRS.primary_web_endpoint
  description = "The endpoint URL for web storage in the primary location."
}
output "primary_web_host_staticwebsiteRAGRS" {
  value       = module.storagestaticwebsiteRAGRS.primary_web_host
  description = "The hostname with port if applicable for web storage in the primary location."
}
output "secondary_web_endpoint_staticwebsiteRAGRS" {
  value       = module.storagestaticwebsiteRAGRS.secondary_web_endpoint
  description = "The endpoint URL for web storage in the secondary location."
}
output "secondary_web_host_staticwebsiteRAGRS" {
  value       = module.storagestaticwebsiteRAGRS.secondary_web_host
  description = "The hostname with port if applicable for web storage in the secondary location."
}

##
output "storage_id_iplist" {
  value       = module.storageiplist.storage_id
  description = "The ID of the storage account."
}