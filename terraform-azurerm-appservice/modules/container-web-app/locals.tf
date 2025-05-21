locals {
  default_site_config = {
    always_on         = "true"
    http2_enabled     = "true"
    ftps_state        = "Disabled"
    use_32_bit_worker = "false"
    ip_restriction    = concat(local.subnets, local.cidrs, local.service_tags)
  }

  site_config = merge(local.default_site_config, var.site_config)

  app_service_id = "/subscriptions/${data.azurerm_subscription.current_subscription.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Web/sites/${var.app_service_name}"


  website_auth_app_settings = {
    WEBSITE_AUTH_ENCRYPTION_KEY = try(var.website_auth_encryption_key, null) == null ? random_bytes.WEBSITE_AUTH_ENCRYPTION_KEY.hex : var.website_auth_encryption_key
    WEBSITE_AUTH_SIGNING_KEY    = try(var.website_auth_signing_key, null) == null ? random_bytes.WEBSITE_AUTH_SIGNING_KEY.hex : var.website_auth_signing_key
  }

  application_insights_appsettings = var.application_insights_enabled ? {
    APPLICATION_INSIGHTS_IKEY             = try(var.application_insights_instrumentation_key, "")
    APPINSIGHTS_INSTRUMENTATIONKEY        = try(var.application_insights_instrumentation_key, "")
    APPLICATIONINSIGHTS_CONNECTION_STRING = try(var.application_insights_connection_string, "")
  } : {}

  default_app_settings = merge(local.website_auth_app_settings, local.application_insights_appsettings)

  container_app_settings = {
    WEBSITES_CONTAINER_START_TIME_LIMIT = try(var.start_time_limit, "")
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = try(var.enable_storage, "")
    WEBSITES_PORT                       = try(var.docker_port, "")
  }

  app_settings = merge(local.default_app_settings, local.container_app_settings, var.app_settings)

  public_network_access_enabled = var.public_network_access_enabled

  default_ip_restrictions_headers_cidr = {
    x_azure_fdid      = null
    x_fd_health_probe = null
    x_forwarded_for   = null
    x_forwarded_host  = null
  }

  default_ip_restrictions_headers_subnet = {
    x_azure_fdid      = null
    x_fd_health_probe = null
    x_forwarded_for   = null
    x_forwarded_host  = null
  }

  default_ip_restrictions_headers = {
    x_azure_fdid      = try(formatlist("%s", var.authorized_x_azure_fdid), null)
    x_fd_health_probe = null
    x_forwarded_for   = null
    x_forwarded_host  = null
  }

  ip_restriction_headers_cidr        = var.ip_restriction_headers != null ? [merge(local.default_ip_restrictions_headers_cidr, var.ip_restriction_headers)] : []
  ip_restriction_headers_subnet      = var.ip_restriction_headers != null ? [merge(local.default_ip_restrictions_headers_subnet, var.ip_restriction_headers)] : []
  ip_restriction_headers_servicetags = var.ip_restriction_headers != null || var.authorized_x_azure_fdid != null ? [merge(local.default_ip_restrictions_headers, var.ip_restriction_headers)] : []

  cidrs = [for cidr in var.authorized_ips : {
    name                      = "ip_restriction_cidr_${join("", [1, index(var.authorized_ips, cidr)])}"
    ip_address                = cidr
    virtual_network_subnet_id = null
    service_tag               = null
    priority                  = join("", [1, index(var.authorized_ips, cidr)])
    action                    = "Allow"
    headers                   = local.ip_restriction_headers_cidr
  }]

  subnets = [for subnet in var.authorized_subnet_ids : {
    name                      = "ip_restriction_subnet_${join("", [1, index(var.authorized_subnet_ids, subnet)])}"
    ip_address                = null
    virtual_network_subnet_id = subnet
    service_tag               = null
    priority                  = join("", [1, index(var.authorized_subnet_ids, subnet)])
    action                    = "Allow"
    headers                   = local.ip_restriction_headers_subnet
  }]

  service_tags = [for service_tag in var.authorized_service_tags : {
    name                      = "service_tag_restriction_${join("", [1, index(var.authorized_service_tags, service_tag)])}"
    ip_address                = null
    virtual_network_subnet_id = null
    service_tag               = service_tag
    priority                  = join("", [1, index(var.authorized_service_tags, service_tag)])
    action                    = "Allow"
    headers                   = local.ip_restriction_headers_servicetags
  }]

  scm_ip_restriction_headers = var.scm_ip_restriction_headers != null ? [merge(local.default_ip_restrictions_headers, var.scm_ip_restriction_headers)] : []

  scm_cidrs = [for cidr in var.scm_authorized_ips : {
    name                      = "scm_ip_restriction_cidr_${join("", [1, index(var.scm_authorized_ips, cidr)])}"
    ip_address                = cidr
    virtual_network_subnet_id = null
    service_tag               = null
    priority                  = join("", [1, index(var.scm_authorized_ips, cidr)])
    action                    = "Allow"
    headers                   = local.scm_ip_restriction_headers
  }]

  scm_subnets = [for subnet in var.scm_authorized_subnet_ids : {
    name                      = "scm_ip_restriction_subnet_${join("", [1, index(var.scm_authorized_subnet_ids, subnet)])}"
    ip_address                = null
    virtual_network_subnet_id = subnet
    service_tag               = null
    priority                  = join("", [1, index(var.scm_authorized_subnet_ids, subnet)])
    action                    = "Allow"
    headers                   = local.scm_ip_restriction_headers
  }]

  scm_service_tags = [for service_tag in var.scm_authorized_service_tags : {
    name                      = "scm_service_tag_restriction_${join("", [1, index(var.scm_authorized_service_tags, service_tag)])}"
    ip_address                = null
    virtual_network_subnet_id = null
    service_tag               = service_tag
    priority                  = join("", [1, index(var.scm_authorized_service_tags, service_tag)])
    action                    = "Allow"
    headers                   = local.scm_ip_restriction_headers
  }]

  auth_settings_v2 = merge(
    {
      auth_enabled = var.aad_client_id == null ? false : true
      active_directory_v2 = {
        client_id            = var.aad_client_id                                                                # (Required) The ID of the Client to use to authenticate with Azure Active Directory.
        tenant_auth_endpoint = format("https://sts.windows.net/%s/", data.azurerm_client_config.main.tenant_id) # (Required) The Azure Tenant Endpoint for the Authenticating Tenant. e.g. https://login.microsoftonline.com/v2.0/{tenant-guid}/
        # One of client_secret_setting_name or client_secret_certificate_thumbprint must be specified.
        client_secret_setting_name = "EASYAUTH2_CLIENT_SECRET" # client_secret_setting_name - (Optional) The App Setting name that contains the client secret of the Client. Mote: A setting with this name must exist in app_settings to function correctly.
        # client_secret_certificate_thumbprint = ""       #   (Optional) The thumbprint of the certificate used for signing purposes.
        allowed_audiences = length(var.allowed_audiences) > 0 ? var.allowed_audiences : null
      }
  }, var.auth_settings_v2)

  auth_settings_v2_login_default = {
    token_store_enabled               = false
    token_refresh_extension_time      = 72
    preserve_url_fragments_for_logins = false
    cookie_expiration_convention      = "FixedTime"
    cookie_expiration_time            = "08:00:00"
    validate_nonce                    = true
    nonce_expiration_time             = "00:05:00"
  }

  auth_settings_v2_login = try(var.auth_settings_v2.login, local.auth_settings_v2_login_default)


}

