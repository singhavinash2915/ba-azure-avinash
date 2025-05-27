variable "location" {
  description = "Azure location."
  type        = string
}
variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}
variable "app_insights_name" {
  description = "Application Insights Name"
  type        = string
  default     = ""
}
variable "application_type" {
  description = "Application type for Application Insights resource Valid values are ios for iOS, java for Java web, MobileCenter for App Center, Node.JS for Node.js, other for General, phone for Windows Phone, store for Windows Store and web for ASP.NET. Please note these values are case sensitive; unmatched values are treated as ASP.NET by Azure."
  type        = string
  default     = "other"
}
variable "tags" {
  description = "A map of tags to set on every taggable resources. Empty by default."
  type        = map(string)
  default     = {}
}
variable "sku" {
  description = "Specifies the SKU of the Log Analytics Workspace. Possible values are Free, PerNode, Premium, Standard, Standalone, Unlimited, CapacityReservation, and PerGB2018 (new SKU as of 2018-04-03). Defaults to PerGB2018."
  type        = string
  default     = "PerGB2018"
}
variable "retention_in_days" {
  description = "Specifies the retention period in days of the Log Analytics Workspace. Possible values are 30, 60, 90, 120, 180, 270, 365, 550 or 730. Defaults to 30"
  type        = number
  default     = 30
}

variable "createloganalytigsworkspace" {
  description = "Create Log Analytics Workspace where Diagnostics Data can be sent. You have to specify azurerm_monitor_diagnostic_setting resource to send data to Log Analytics Workspace."
  type        = bool
  default     = true
}

variable "createstorageaccount" {
  description = "Create Storage Account where logs can be sent. You have to specify azurerm_monitor_diagnostic_setting resource to send data to Storage Account."
  type        = bool
  default     = false
}

variable "storage_account_replication_type" {
  description = "Specifies the type of replication to use for log storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS. Defaults to LRS."
  type        = string
  default     = "LRS"

}

variable "storage_account_tier" {
  description = "Specifies the Tier to use for this storage account. Valid options are Standard and Premium. Defaults to Standard."
  type        = string
  default     = "Standard"

}