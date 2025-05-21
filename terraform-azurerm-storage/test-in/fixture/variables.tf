variable "location" {
  type        = string
  default     = "westeurope"
  description = "The name of the location."
}
variable "subnet_intranet_name_suffix" {
  type        = string
  default     = "_Intranet"
  description = "The suffix of the intranet subnet"
}

# variable "subnet_webapp_name_suffix" {
#   type        = string
#   default     = "_serverFarms"
#   description = "The suffix of the webapp subnet"
# }