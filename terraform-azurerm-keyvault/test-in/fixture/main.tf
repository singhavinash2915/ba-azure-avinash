module "keyvault" {
  source = "./../.." # Use the local version to test it

  keyvault_name       = "${local.prefix_kebab}-${local.hash_suffix}-kv"
  location            = module.rg.resource_group_location
  resource_group_name = module.rg.resource_group_name

  user_objects_ids = [
    "7d67bbe4-9903-47d0-96ef-25825be895f3", //admkrohm
    "00c7f1a0-2aab-4cea-9dc6-1089705a7f26"  //admfabianma
  ]

  reader_objects_ids = [
    "340f027b-3d2f-408c-b33e-961e9fe8e627", //Frontdoor
    "4a0b4e9b-0dab-4741-92dc-ee98e7102517"  // WebApp
  ]
  public_network_access_enabled = false
  enable_rbac_authorization     = true
}
module "privateendpointkeyvault" {

  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-privateendpoint"

  location            = data.azurerm_virtual_network.vn.location
  resource_group_name = module.rg.resource_group_name
  pe_name             = "${local.prefix_kebab}-${local.hash_suffix}-pendpkeyvault"
  subnet_id           = local.subnet_id
  target_resource     = module.keyvault.key_vault_id
  subresource_names   = ["vault"]
}