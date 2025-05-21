output "key_vault_id" {
  description = "Id of the Key Vault"
  value       = azurerm_key_vault.keyvault.id
}

output "key_vault_name" {
  description = "Name of the Key Vault"
  value       = azurerm_key_vault.keyvault.name
}

output "key_vault_uri" {
  description = "URI of the Key Vault"
  value       = azurerm_key_vault.keyvault.vault_uri
}

output "service_principle_policy_id" {
  description = "Id of the Service Principle Policy"
  value       = azurerm_key_vault_access_policy.service_principle_policy.id
}
