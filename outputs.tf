output "virtual_network_id" {
  description = "Virtual network generated id"
  value       = azurerm_virtual_network.vnet.id
}

output "virtual_network_location" {
  description = "Virtual network location"
  value       = azurerm_virtual_network.vnet.location
}

output "virtual_network_name" {
  description = "Virtual network name"
  value       = azurerm_virtual_network.vnet.name
}

output "virtual_network_space" {
  description = "Virtual network space"
  value       = azurerm_virtual_network.vnet.address_space
}

output "subnet_ids" {
  description = "List of IDs of subnets"
  value       = [for s in azurerm_virtual_network.vnet.subnet : s.id]
}

output "subnet_address_prefixes" {
  description = "List of address prefix for subnets"
  value       = [for s in azurerm_virtual_network.vnet.subnet : s.address_prefixes]
}

output "subnet_names" {
  description = "Names of the created subnets"
  value       = [for s in azurerm_virtual_network.vnet.subnet : s.name]
}

output "named_subnet_ids" {
  description = "Map of subnet resources"
  value = zipmap(
    [for s in azurerm_virtual_network.vnet.subnet : s.name],
    [for s in azurerm_virtual_network.vnet.subnet : s.id]
  )
}
output "network_security_group_ids" {
  description = "List of Network security group id"
  value       = [for n in azurerm_network_security_group.nsg : n.id]
}

output "network_security_group_names" {
  description = "List of Network security group name"
  value       = [for n in azurerm_network_security_group.nsg : n.name]
}


