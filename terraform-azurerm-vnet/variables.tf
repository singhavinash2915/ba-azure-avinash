variable "location" {
  description = "Azure region to use"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "vnet_name" {
  description = "Name of the Vnet"
  type        = string
}

variable "vnet_cidr" {
  description = "The address space that is used by the virtual network"
  type        = list(string)
}

variable "dns_servers" {
  description = "List of IP addresses of DNS servers"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "tags to add"
  type        = map(string)
  default     = {}
}

variable "subnets" {
  description = "For each subnet, create an object that contain fields"
  default     = {}
}
