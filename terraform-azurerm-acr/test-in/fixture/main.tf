locals {
  subnet_id = "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/BASF_RG_Network_${data.azurerm_subscription.current.display_name}/providers/Microsoft.Network/virtualNetworks/BASF_VN_IN_${data.azurerm_subscription.current.display_name}/subnets/BASF_SN_IN_${data.azurerm_subscription.current.display_name}${var.subnet_intranet_name_suffix}"
}

module "acr" {
  source                        = "./../.." # Use the local version to test it
  name                          = "${local.prefix_flat}${local.hash_suffix}"
  location                      = module.rg.resource_group_location
  resource_group_name           = module.rg.resource_group_name
  sku                           = "Premium" //only Premius cann disallow public:network_access
  admin_enabled                 = true
  public_network_access_enabled = false
}



