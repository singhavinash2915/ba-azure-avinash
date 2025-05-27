data "azurerm_subscription" "current_subscription" {}
data "azurerm_client_config" "main" {}


locals {
  app_insights_name            = "${var.app_insights_name}-ai"
  log_analytics_workspace_name = "${local.app_insights_name}-la"
  # Storage Account Name has to be unique and can only consist of lowercase letters and numbers, and must be between 3 and 24 characters long
  # Storage Account Name will be generated as follows: var.app_insights_name-ai-sa
  storage_account_name = length(replace(replace(local.app_insights_name, "-", ""), "_", "")) > 22 ? "${substr(replace(replace(local.app_insights_name, "-", ""), "_", ""), 0, 22)}sa" : "${replace(replace(local.app_insights_name, "-", ""), "_", "")}sa"
}
