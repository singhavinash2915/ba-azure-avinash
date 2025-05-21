variable "name" {
  type        = string
  description = "The name of the storage account."
}

variable "resource_group_name" {
  type        = string
  description = "The name of an existing resource group."
}

variable "location" {
  type        = string
  default     = ""
  description = "The name of the location."
}

variable "kind" {
  type        = string
  default     = "StorageV2"
  description = "The kind of storage account."
}

variable "sku" {
  type        = string
  default     = "Standard_LRS"
  description = "The SKU of the storage account."
}

variable "access_tier" {
  type        = string
  default     = "Hot"
  description = "The access tier of the storage account."
}

variable "https_only" {
  type        = bool
  default     = true
  description = "Set to `true` to only allow HTTPS traffic, or `false` to disable it."
}

variable "is_hns_enabled" {
  type        = bool
  default     = false
  description = "Is Hierarchical Namespace enabled?"
}

variable "assign_identity" {
  type        = bool
  default     = true
  description = "Set to `true` to enable system-assigned managed identity, or `false` to disable it."
}

variable "blob_properties" {
  type        = any
  default     = null
  description = "Blob properties block"
}

variable "blobs" {
  type        = list(any)
  default     = []
  description = "List of storage blobs."
}

variable "containers" {
  type = list(object({
    name        = string
    access_type = string
  }))
  default     = []
  description = "List of storage containers."
}

variable "queues" {
  type        = list(string)
  default     = []
  description = "List of storages queues."
}

variable "shares" {
  type = list(object({
    name  = string
    quota = number
  }))
  default     = []
  description = "List of storage shares."
}

variable "tables" {
  type        = list(string)
  default     = []
  description = "List of storage tables."
}

variable "min_tls_version" {
  type        = string
  default     = "TLS1_2"
  description = "The minimum supported TLS version for the storage account"
  validation {
    condition     = var.min_tls_version == "TLS1_0" || var.min_tls_version == "TLS1_1" || var.min_tls_version == "TLS1_2"
    error_message = "The minimum supported TLS version of the storage account must be set to TLS_0, TLS_1 or TLS_2."
  }
}

variable "tags" {
  type    = map(any)
  default = {}
}

variable "storage_vnet_integration_subnet_id" {
  description = "Id of the subnet to associate with the storage"
  type        = list(any)
  default     = []
}

variable "storage_public_ip_list_allowed" {
  type        = list(string)
  default     = []
  description = "List of public IPs from the internet or on-premises-networks which will be granted access to storage account. Only public IPv4 addresses in CIDR format are allowed."
}

variable "nfsv3_enabled" {
  type        = bool
  default     = false
  description = "Is NFSv3 protocol enabled? Changing this forces a new resource to be created. Defaults to false."
}

variable "default_action" {
  type        = string
  default     = "Allow"
  description = "Specifies the default action of allow or deny when no other rules match. Valid options are Deny or Allow."
}
variable "allow_nested_items_to_be_public" {
  type        = bool
  default     = false
  description = "Allow or disallow nested items within this Account to opt into being public. Defaults to false"
}
variable "shared_access_key_enabled" {
  type        = bool
  default     = true
  description = "Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. If false, then all requests, including shared access signatures, must be authorized with Azure Active Directory (Azure AD). The default value is true"
}
variable "public_network_access_enabled" {
  type        = bool
  default     = true
  description = "Indicates whether the storage account permits requests from public. The default value is true"
}

variable "static_website_enabled" {
  type        = bool
  default     = false
  description = "Indicates whether the storage account activates static website hosting. The default value is false. Can only be set when the kind is set to StorageV2 or BlockBlobStorage."
}

variable "static_website_index_document" {
  type        = string
  default     = "index.html"
  description = "The webpage that Azure Storage serves for requests to the root of a website or any subfolder. For example, index.html. The value is case-sensitive. The default value is index.html."
}
variable "static_website_error_404_document" {
  type        = string
  default     = "error_404.html"
  description = "The absolute path to a custom webpage that should be used when a request is made which does not correspond to an existing file. The value is case-sensitive. The default value is error_404.html."
}
variable "cross_tenant_replication_enabled" {
  type        = bool
  default     = false
  description = "Allow cross tenant replication for blob storage accounts"
}
