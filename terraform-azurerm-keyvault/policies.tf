resource "azurerm_key_vault_access_policy" "service_principle_policy" {


  object_id    = data.azurerm_client_config.current.object_id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  key_vault_id = azurerm_key_vault.keyvault.id

  key_permissions = [
    "Get",
    "List",
    "Create",
    "Update",
    "Delete",
    "Purge",
    "UnwrapKey",
    "WrapKey",
    "Purge",
    "Encrypt",
    "Decrypt",
    "Sign",
    "Verify",
    "GetRotationPolicy",
    "SetRotationPolicy"
  ]

  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete",
    "Purge",
  ]

  certificate_permissions = [
    "Get",
    "List",
    "Update",
    "Delete",
    "Create",
    "Import",
    "GetIssuers",
    "SetIssuers",
    "ManageIssuers",
    "ListIssuers",

  ]
}


resource "azurerm_key_vault_access_policy" "readers_policy" {
  for_each = toset(var.reader_objects_ids)

  object_id    = each.value
  tenant_id    = data.azurerm_client_config.current.tenant_id
  key_vault_id = azurerm_key_vault.keyvault.id

  key_permissions = [
    "Get",
    "List",
  ]

  secret_permissions = [
    "Get",
    "List",
  ]

  certificate_permissions = [
    "Get",
    "List",
  ]
}
resource "azurerm_key_vault_access_policy" "users_policy" {
  for_each = toset(var.user_objects_ids)

  object_id    = each.value
  tenant_id    = data.azurerm_client_config.current.tenant_id
  key_vault_id = azurerm_key_vault.keyvault.id

  key_permissions = [
    "Get",
    "List",
    "Update",
    "Delete",
  ]

  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete",
  ]

  certificate_permissions = [
    "Create",
    "Get",
    "List",
    "Update",
    "Delete",
    "Import",
  ]
}
resource "azurerm_key_vault_access_policy" "devopsusers_policy" {
  for_each = toset(var.devopsuser_objects_ids)

  object_id    = each.value
  tenant_id    = data.azurerm_client_config.current.tenant_id
  key_vault_id = azurerm_key_vault.keyvault.id

  key_permissions = [
    "Get",
    "List",
    "Update",
    "Create",
    "Delete",
    "Recover",
    "Purge",
  ]

  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete",
    "Recover",
    "Purge",
  ]

  certificate_permissions = [
    "Get",
    "List",
    "Update",
    "Create",
    "Import",
    "Delete",
    "Recover",
    "Purge",
  ]


}
resource "azurerm_key_vault_access_policy" "admin_policy" {
  for_each = toset(var.admin_objects_ids)

  object_id    = each.value
  tenant_id    = data.azurerm_client_config.current.tenant_id
  key_vault_id = azurerm_key_vault.keyvault.id

  key_permissions = [
    "Backup",
    "Create",
    "Decrypt",
    "Delete",
    "Encrypt",
    "Get",
    "Import",
    "List",
    "Purge",
    "Recover",
    "Restore",
    "Sign",
    "UnwrapKey",
    "Update",
    "Verify",
    "WrapKey",
  ]

  secret_permissions = [
    "Backup",
    "Delete",
    "Get",
    "List",
    "Purge",
    "Recover",
    "Restore",
    "Set",
  ]

  certificate_permissions = [
    "Backup",
    "Create",
    "Delete",
    "DeleteIssuers",
    "Get",
    "GetIssuers",
    "Import",
    "List",
    "ListIssuers",
    "ManageContacts",
    "ManageIssuers",
    "Purge",
    "Recover",
    "Restore",
    "SetIssuers",
    "Update",
  ]
}
