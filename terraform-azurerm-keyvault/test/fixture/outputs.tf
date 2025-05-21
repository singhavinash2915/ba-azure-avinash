output "key_vault_id" {
  description = "Id of the Key Vault"
  value       = module.keyvault.key_vault_id
}
output "key_vault_id_kv" {
  description = "Id of the Key Vault"
  value       = module.keyvault_kv.key_vault_id
}
output "key_vault_name" {
  description = "Name of the Key Vault"
  value       = module.keyvault.key_vault_name
}

output "key_vault_uri" {
  description = "URI of the Key Vault"
  value       = module.keyvault.key_vault_uri
}

output "service_principle_policy_id" {
  description = "Id of the Service Principle Policy"
  value       = module.keyvault.service_principle_policy_id
}

output "resource_versionless_id" {
  description = "The Versionless ID of the Key Vault Key"
  value       = azurerm_key_vault_key.kv_key.resource_versionless_id
}