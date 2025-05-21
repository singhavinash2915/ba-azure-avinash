module "keyvault" {
  source = "./../.." # Use the local version to test it

  keyvault_name       = "${local.prefix_kebab}-${local.hash_suffix}-kv"
  location            = module.rg.resource_group_location
  resource_group_name = module.rg.resource_group_name

  devopsuser_objects_ids = [
    "7d67bbe4-9903-47d0-96ef-25825be895f3", //admkrohm
    "00c7f1a0-2aab-4cea-9dc6-1089705a7f26"  //admfabianma
  ]

  reader_objects_ids = [
    "340f027b-3d2f-408c-b33e-961e9fe8e627", //Frontdoor
    "4a0b4e9b-0dab-4741-92dc-ee98e7102517"  // WebApp
  ]

}


module "keyvault_kv" {
  source = "./../.." # Use the local version to test it

  keyvault_name                 = "k${formatdate("DDMMMYYYYhhmmZZZ", timestamp())}"
  location                      = module.rg.resource_group_location
  resource_group_name           = module.rg.resource_group_name
  public_network_access_enabled = true
  purge_protection_enabled      = true


  user_objects_ids = [
    "7d67bbe4-9903-47d0-96ef-25825be895f3", //admkrohm
    "00c7f1a0-2aab-4cea-9dc6-1089705a7f26"  //admfabianma
  ]

  reader_objects_ids = [
    "340f027b-3d2f-408c-b33e-961e9fe8e627", //Frontdoor
    "4a0b4e9b-0dab-4741-92dc-ee98e7102517"  // WebApp
  ]

}
resource "azurerm_key_vault_key" "kv_key" {

  name         = "kv-key"
  key_vault_id = module.keyvault_kv.key_vault_id
  key_type     = "RSA"
  key_size     = 2048
  key_opts     = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
  rotation_policy {
    automatic {
      time_before_expiry = "P30D"
    }
    notify_before_expiry = "P15D"
    expire_after         = "P180D"
  }
  depends_on = [module.keyvault_kv]

}
