variable "location" {
  type    = string
  default = "westeurope"
}
variable "subnet_intranet_name_suffix" {
  type        = string
  default     = "_Intranet"
  description = "The suffix of the intranet subnet"
}

variable "subnet_webapp_name_suffix" {
  type        = string
  default     = "_Intranet2"
  description = "The suffix of the webapp subnet"
}