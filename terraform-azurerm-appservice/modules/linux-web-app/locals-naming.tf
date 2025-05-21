locals {

  staging_slot_name = coalesce(var.staging_slot_custom_name, "staging-slot")
  backup_name       = coalesce(var.backup_custom_name, "DefaultBackup")
}