module "linux_web_app" {
  for_each = toset(lower(local.os_type) == "linux" ? ["enabled"] : [])

  source = "./modules/linux-web-app"

  app_service_name    = var.app_service_name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = var.app_service_plan_id

  app_settings                  = var.app_settings
  public_network_access_enabled = var.public_network_access_enabled

  webdeploy_publish_basic_authentication_enabled = var.webdeploy_publish_basic_authentication_enabled
  ftp_publish_basic_authentication_enabled       = var.ftp_publish_basic_authentication_enabled

  site_config       = var.site_config
  auth_settings_v2  = var.auth_settings_v2
  aad_client_id     = var.aad_client_id
  allowed_audiences = var.allowed_audiences

  connection_strings = var.connection_strings

  mount_points                       = var.mount_points
  client_affinity_enabled            = var.client_affinity_enabled
  https_only                         = var.https_only
  client_certificate_enabled         = var.client_certificate_enabled
  client_certificate_mode            = var.client_certificate_mode
  client_certificate_exclusion_paths = var.client_certificate_exclusion_paths

  app_service_vnet_integration_subnet_id = local.app_service_vnet_integration_subnet_id

  staging_slot_enabled             = var.staging_slot_enabled
  staging_slot_custom_name         = var.staging_slot_custom_name
  staging_slot_custom_app_settings = var.staging_slot_custom_app_settings

  custom_domains                  = var.custom_domains
  authorized_ips                  = var.authorized_ips
  identity_type                   = var.identity_type
  identity_ids                    = var.identity_ids
  key_vault_reference_identity_id = var.key_vault_reference_identity_id
  ip_restriction_default_action   = var.ip_restriction_default_action
  ip_restriction_headers          = var.ip_restriction_headers
  authorized_subnet_ids           = var.authorized_subnet_ids
  authorized_service_tags         = var.authorized_service_tags
  scm_ip_restriction_headers      = var.scm_ip_restriction_headers
  scm_authorized_ips              = var.scm_authorized_ips
  scm_authorized_subnet_ids       = var.scm_authorized_subnet_ids
  scm_authorized_service_tags     = var.scm_authorized_service_tags


  backup_enabled                   = var.backup_enabled
  backup_custom_name               = var.backup_custom_name
  backup_storage_account_rg        = var.backup_storage_account_rg
  backup_storage_account_name      = var.backup_storage_account_name
  backup_storage_account_container = var.backup_storage_account_container
  backup_frequency_interval        = var.backup_frequency_interval
  backup_retention_period_in_days  = var.backup_retention_period_in_days
  backup_frequency_unit            = var.backup_frequency_unit
  backup_keep_at_least_one_backup  = var.backup_keep_at_least_one_backup




  application_insights_enabled = var.application_insights_enabled

  application_insights_instrumentation_key = var.application_insights_instrumentation_key
  application_insights_connection_string   = var.application_insights_connection_string

  authorized_x_azure_fdid  = var.authorized_x_azure_fdid
  custom_domains_azure     = var.custom_domains_azure
  docker_registry_username = var.docker_registry_username
  docker_registry_url      = var.docker_registry_url
  docker_registry_password = var.docker_registry_password
  docker_port              = var.docker_port
  start_time_limit         = var.start_time_limit
  enable_storage           = var.enable_storage

  website_auth_encryption_key = var.website_auth_encryption_key
  website_auth_signing_key    = var.website_auth_signing_key

  tags = var.tags
}

module "container_web_app" {
  for_each = toset(lower(local.os_type) == "container" ? ["enabled"] : [])

  source = "./modules/container-web-app"

  app_service_name              = var.app_service_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  service_plan_id               = var.app_service_plan_id
  public_network_access_enabled = var.public_network_access_enabled

  webdeploy_publish_basic_authentication_enabled = var.webdeploy_publish_basic_authentication_enabled
  ftp_publish_basic_authentication_enabled       = var.ftp_publish_basic_authentication_enabled

  docker_image = var.docker_image

  app_settings      = var.app_settings
  site_config       = var.site_config
  auth_settings_v2  = var.auth_settings_v2
  aad_client_id     = var.aad_client_id
  allowed_audiences = var.allowed_audiences

  connection_strings = var.connection_strings

  mount_points                       = var.mount_points
  client_affinity_enabled            = var.client_affinity_enabled
  https_only                         = var.https_only
  client_certificate_enabled         = var.client_certificate_enabled
  client_certificate_mode            = var.client_certificate_mode
  client_certificate_exclusion_paths = var.client_certificate_exclusion_paths

  app_service_vnet_integration_subnet_id = local.app_service_vnet_integration_subnet_id

  staging_slot_enabled             = var.staging_slot_enabled
  staging_slot_custom_name         = var.staging_slot_custom_name
  staging_slot_custom_app_settings = var.staging_slot_custom_app_settings

  custom_domains                  = var.custom_domains
  authorized_ips                  = var.authorized_ips
  identity_type                   = var.identity_type
  identity_ids                    = var.identity_ids
  key_vault_reference_identity_id = var.key_vault_reference_identity_id
  ip_restriction_default_action   = var.ip_restriction_default_action
  ip_restriction_headers          = var.ip_restriction_headers
  authorized_subnet_ids           = var.authorized_subnet_ids
  authorized_service_tags         = var.authorized_service_tags
  scm_ip_restriction_headers      = var.scm_ip_restriction_headers
  scm_authorized_ips              = var.scm_authorized_ips
  scm_authorized_subnet_ids       = var.scm_authorized_subnet_ids
  scm_authorized_service_tags     = var.scm_authorized_service_tags




  backup_enabled                   = var.backup_enabled
  backup_custom_name               = var.backup_custom_name
  backup_storage_account_rg        = var.backup_storage_account_rg
  backup_storage_account_name      = var.backup_storage_account_name
  backup_storage_account_container = var.backup_storage_account_container
  backup_frequency_interval        = var.backup_frequency_interval
  backup_retention_period_in_days  = var.backup_retention_period_in_days
  backup_frequency_unit            = var.backup_frequency_unit
  backup_keep_at_least_one_backup  = var.backup_keep_at_least_one_backup




  application_insights_enabled = var.application_insights_enabled

  application_insights_instrumentation_key = var.application_insights_instrumentation_key
  application_insights_connection_string   = var.application_insights_connection_string

  authorized_x_azure_fdid  = var.authorized_x_azure_fdid
  custom_domains_azure     = var.custom_domains_azure
  docker_registry_username = var.docker_registry_username
  docker_registry_url      = var.docker_registry_url
  docker_registry_password = var.docker_registry_password
  docker_port              = var.docker_port
  start_time_limit         = var.start_time_limit
  enable_storage           = var.enable_storage

  website_auth_encryption_key = var.website_auth_encryption_key
  website_auth_signing_key    = var.website_auth_signing_key

  tags = var.tags
}

module "windows_web_app" {
  for_each = toset(lower(local.os_type) == "windows" ? ["enabled"] : [])

  source = "./modules/windows-web-app"

  app_service_name    = var.app_service_name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = var.app_service_plan_id

  app_settings                  = var.app_settings
  site_config                   = var.site_config
  auth_settings_v2              = var.auth_settings_v2
  aad_client_id                 = var.aad_client_id
  allowed_audiences             = var.allowed_audiences
  public_network_access_enabled = var.public_network_access_enabled

  webdeploy_publish_basic_authentication_enabled = var.webdeploy_publish_basic_authentication_enabled
  ftp_publish_basic_authentication_enabled       = var.ftp_publish_basic_authentication_enabled

  connection_strings = var.connection_strings

  mount_points                       = var.mount_points
  client_affinity_enabled            = var.client_affinity_enabled
  https_only                         = var.https_only
  client_certificate_enabled         = var.client_certificate_enabled
  client_certificate_mode            = var.client_certificate_mode
  client_certificate_exclusion_paths = var.client_certificate_exclusion_paths

  app_service_vnet_integration_subnet_id = local.app_service_vnet_integration_subnet_id

  staging_slot_enabled             = var.staging_slot_enabled
  staging_slot_custom_name         = var.staging_slot_custom_name
  staging_slot_custom_app_settings = var.staging_slot_custom_app_settings

  custom_domains                  = var.custom_domains
  authorized_ips                  = var.authorized_ips
  ip_restriction_default_action   = var.ip_restriction_default_action
  ip_restriction_headers          = var.ip_restriction_headers
  identity_type                   = var.identity_type
  identity_ids                    = var.identity_ids
  key_vault_reference_identity_id = var.key_vault_reference_identity_id
  authorized_subnet_ids           = var.authorized_subnet_ids
  authorized_service_tags         = var.authorized_service_tags
  scm_ip_restriction_headers      = var.scm_ip_restriction_headers
  scm_authorized_ips              = var.scm_authorized_ips
  scm_authorized_subnet_ids       = var.scm_authorized_subnet_ids
  scm_authorized_service_tags     = var.scm_authorized_service_tags




  backup_enabled                   = var.backup_enabled
  backup_custom_name               = var.backup_custom_name
  backup_storage_account_rg        = var.backup_storage_account_rg
  backup_storage_account_name      = var.backup_storage_account_name
  backup_storage_account_container = var.backup_storage_account_container
  backup_frequency_interval        = var.backup_frequency_interval
  backup_retention_period_in_days  = var.backup_retention_period_in_days
  backup_frequency_unit            = var.backup_frequency_unit
  backup_keep_at_least_one_backup  = var.backup_keep_at_least_one_backup




  application_insights_enabled = var.application_insights_enabled

  application_insights_instrumentation_key = var.application_insights_instrumentation_key
  application_insights_connection_string   = var.application_insights_connection_string

  authorized_x_azure_fdid  = var.authorized_x_azure_fdid
  custom_domains_azure     = var.custom_domains_azure
  docker_registry_username = var.docker_registry_username
  docker_registry_url      = var.docker_registry_url
  docker_registry_password = var.docker_registry_password
  docker_port              = var.docker_port
  start_time_limit         = var.start_time_limit
  enable_storage           = var.enable_storage

  website_auth_encryption_key = var.website_auth_encryption_key
  website_auth_signing_key    = var.website_auth_signing_key

  tags = var.tags
}
