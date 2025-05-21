output "privateendpointkeyvault_id" {
  description = "The resource id of the Private Endpoint"
  value       = module.privateendpointkeyvault.privateendpoint_id
}
output "privateendpointkeyvault_ip" {
  description = "The IP of the Private Endpoint"
  value       = module.privateendpointkeyvault.privateendpoint_ip_address
}
output "key_vault_id" {
  description = "Id of the Key Vault"
  value       = module.keyvault.key_vault_id
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