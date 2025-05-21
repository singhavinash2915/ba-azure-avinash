# Generic naming variables

variable "staging_slot_custom_name" {
  type        = string
  description = "Custom name of the app service slot"
  default     = null
}

variable "backup_custom_name" {
  description = "Custom name for backup"
  type        = string
  default     = null
}

