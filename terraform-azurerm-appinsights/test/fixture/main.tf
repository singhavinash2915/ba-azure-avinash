module "app_insights" {
  source              = "./../.." # Use the local version to test it
  app_insights_name   = "${local.prefix_kebab}-${local.hash_suffix}"
  location            = module.rg.resource_group_location
  resource_group_name = module.rg.resource_group_name
  application_type    = "web"
}

resource "azurerm_monitor_diagnostic_setting" "app_insights_azurerm_monitor_diagnostic_setting" {
  name                       = "${local.prefix_kebab}-${local.hash_suffix}-ai-mon"
  target_resource_id         = module.app_insights.application_insights_id
  log_analytics_workspace_id = module.app_insights.log_analytics_workspace_id

  enabled_log {
    category = "AppAvailabilityResults"
  }
  enabled_log {
    category = "AppBrowserTimings"
  }
  enabled_log {
    category = "AppEvents"
  }
  enabled_log {
    category = "AppMetrics"
  }
  enabled_log {
    category = "AppDependencies"
  }
  enabled_log {
    category = "AppExceptions"
  }
  enabled_log {
    category = "AppPageViews"
  }
  enabled_log {
    category = "AppPerformanceCounters"
  }
  enabled_log {
    category = "AppRequests"
  }
  enabled_log {
    category = "AppSystemEvents"
  }
  enabled_log {
    category = "apptraces"
  }

  metric {
    category = "AllMetrics"
  }
}

module "app_insights_sa" {
  source                      = "./../.." # Use the local version to test it
  app_insights_name           = "${local.prefix_kebab}-${local.hash_suffix}-withsa"
  location                    = module.rg.resource_group_location
  resource_group_name         = module.rg.resource_group_name
  application_type            = "web"
  createloganalytigsworkspace = false
  createstorageaccount        = true
}

resource "azurerm_monitor_diagnostic_setting" "app_insights_sa_azurerm_monitor_diagnostic_setting" {
  name               = "${local.prefix_kebab}-${local.hash_suffix}-ai-mon"
  target_resource_id = module.app_insights_sa.application_insights_id
  storage_account_id = module.app_insights_sa.storage_account_id

  enabled_log {
    category = "AppAvailabilityResults"
  }
  enabled_log {
    category = "AppBrowserTimings"
  }
  enabled_log {
    category = "AppEvents"
  }
  enabled_log {
    category = "AppMetrics"
  }
  enabled_log {
    category = "AppDependencies"
  }
  enabled_log {
    category = "AppExceptions"
  }
  enabled_log {
    category = "AppPageViews"
  }
  enabled_log {
    category = "AppPerformanceCounters"
  }
  enabled_log {
    category = "AppRequests"
  }
  enabled_log {
    category = "AppSystemEvents"
  }
  enabled_log {
    category = "apptraces"
  }

  metric {
    category = "AllMetrics"
  }
}
