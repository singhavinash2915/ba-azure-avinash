data "azurerm_subscription" "current" {
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_cidr
  location            = var.location

  dns_servers = var.dns_servers

  tags = var.tags
  dynamic "subnet" {
    for_each = var.subnets
    content {
      name                                          = subnet.key
      address_prefixes                              = subnet.value.subnet_address_prefix
      service_endpoints                             = lookup(subnet.value, "service_endpoints", [])
      private_endpoint_network_policies             = lookup(subnet.value, "enforce_private_link_endpoint_network_policies", null)
      private_link_service_network_policies_enabled = lookup(subnet.value, "enforce_private_link_service_network_policies", null)
      security_group                                = azurerm_network_security_group.nsg[subnet.key].id
      dynamic "delegation" {
        for_each = lookup(subnet.value, "delegation", {}) != {} ? [1] : []
        content {
          name = lookup(subnet.value.delegation, "name", null)
          service_delegation {
            name    = lookup(subnet.value.delegation.service_delegation, "name", null)
            actions = lookup(subnet.value.delegation.service_delegation, "actions", null)
          }
        }
      }
    }
  }
}

locals {
  default_source_address_prefix      = "*"
  default_destination_address_prefix = "*"

  subnet_id_map = { for s in azurerm_virtual_network.vnet.subnet : s.name => s.id }

  subnetnames_with_nsg_list = [for k, v in var.subnets : k]
  subnetnames_with_nsg      = { for subnet_name in local.subnetnames_with_nsg_list : subnet_name => subnet_name }

  nsg_rules = flatten([
    for subnetname_with_nsg in local.subnetnames_with_nsg_list : [
      for rule in lookup(var.subnets[subnetname_with_nsg], "rules", []) : [
        {
          subnet_name = subnetname_with_nsg
          key         = "rule_${subnetname_with_nsg}_${rule.name}"
          rule        = rule
        }
      ]
    ]
  ])
}

resource "azurerm_network_security_group" "nsg" {
  for_each = local.subnetnames_with_nsg
  name     = "${var.vnet_name}-${each.value}-nsg"

  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

resource "azurerm_network_security_rule" "nsg_rules" {
  for_each = {
    for nsg_rule in local.nsg_rules : nsg_rule.key => nsg_rule
  }

  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg[each.value.subnet_name].name

  name                                       = lookup(each.value.rule, "name", "default_rule_name")
  priority                                   = lookup(each.value.rule, "priority")
  direction                                  = lookup(each.value.rule, "direction", "Any")
  access                                     = lookup(each.value.rule, "access", "Allow")
  protocol                                   = title(lookup(each.value.rule, "protocol", "*"))
  source_port_ranges                         = split(",", replace(lookup(each.value.rule, "source_port_range", "*"), "*", "0-65535"))
  destination_port_ranges                    = split(",", replace(lookup(each.value.rule, "destination_port_range", "*"), "*", "0-65535"))
  source_address_prefix                      = lookup(each.value.rule, "source_address_prefix", null)
  source_address_prefixes                    = lookup(each.value.rule, "source_address_prefixes", null)
  destination_address_prefix                 = lookup(each.value.rule, "destination_address_prefix", local.default_destination_address_prefix)
  destination_address_prefixes               = lookup(each.value.rule, "destination_address_prefixes", null)
  description                                = lookup(each.value.rule, "description", "")
  source_application_security_group_ids      = lookup(each.value.rule, "source_application_security_group_ids", null)
  destination_application_security_group_ids = lookup(each.value.rule, "destination_application_security_group_ids", null)
}