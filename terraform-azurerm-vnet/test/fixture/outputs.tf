output "virtual_network_id" {
  description = "Virtual network generated id"
  value       = module.vnet.virtual_network_id
}

output "virtual_network_location" {
  description = "Virtual network location"
  value       = module.vnet.virtual_network_location
}

output "virtual_network_name" {
  description = "Virtual network name"
  value       = module.vnet.virtual_network_name
}

output "virtual_network_space" {
  description = "Virtual network space"
  value       = module.vnet.virtual_network_space
}

output "subnet_ids" {
  description = "List of IDs of subnets"
  value       = module.vnet.subnet_ids
}

output "subnet_address_prefixes" {
  description = "List of address prefix for subnets"
  value       = module.vnet.subnet_address_prefixes
}

output "subnet_names" {
  description = "Names of the created subnets"
  value       = module.vnet.subnet_names
}

output "named_subnet_ids" {
  description = "Map of subnet resources"
  value       = module.vnet.named_subnet_ids
}

output "network_security_group_ids" {
  description = "List of Network security group id"
  value       = module.vnet.network_security_group_ids
}

output "network_security_group_names" {
  description = "List of Network security group name"
  value       = module.vnet.network_security_group_names
}