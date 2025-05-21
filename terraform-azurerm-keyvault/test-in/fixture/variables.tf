variable "location" {
  type    = string
  default = "westeurope"
}
variable "subnet_intranet_name_suffix" {
  type        = string
  default     = "_Intranet"
  description = "The suffix of the intranet subnet"
}