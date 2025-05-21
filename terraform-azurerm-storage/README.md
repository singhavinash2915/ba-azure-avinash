# Azure Storage

This Terraform module creates an [Azure Storage Account](hhttps://docs.microsoft.com/en-us/azure/storage/)

<!-- BEGIN_TF_DOCS -->
## Usage

This module is optimized to work with the [BASF Terraform Runner](https://docs.cloudreference.basf.com/) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `BASF Terraform Runner` available in the [documentation](https://docs.cloudreference.basf.com/).

### Example usage PI  

```hcl
module "storage" {
  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-storage?ref=4.1" 
  name                               = "${local.prefix_flat}${local.hash_suffix}sa"
  location                           = module.rg.resource_group_location
  resource_group_name                = module.rg.resource_group_name
  min_tls_version                    = "TLS1_2"
  storage_vnet_integration_subnet_id = [module.vnet.named_subnet_ids["subnet_backend"], module.vnet.named_subnet_ids["subnet_management"]]
  storage_public_ip_list_allowed     = ["18.158.255.211/24", "20.113.58.168/24"]
  # Be carful with default_action = "Deny" -> see input parameter documentation
  default_action = "Allow"

  allow_nested_items_to_be_public = true
  shared_access_key_enabled       = false
  containers = [
    {
      name        = "data"
      access_type = "private"
    }
  ]
}

# Example for hosting Static WebSites in Azure Storage in one Region
module "storagestaticwebsite" {
  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-storage?ref=4.1" 
  name                = "${local.prefix_flat}${local.hash_suffix}web"
  location            = module.rg.resource_group_location
  resource_group_name = module.rg.resource_group_name
  min_tls_version     = "TLS1_2"

  # Be carful with default_action = "Deny" -> see input parameter documentation
  default_action = "Allow"

  # sku                    = "Standard_LRS" # this is the default value
  static_website_enabled = true

}

# Example for hosting Static WebSites in Azure Storage in multiple Regions with read access
module "storagestaticwebsiteRAGRS" {
  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-storage?ref=4.1" 
  name                = "${local.prefix_flat}${local.hash_suffix}ragr"
  location            = module.rg.resource_group_location
  resource_group_name = module.rg.resource_group_name
  min_tls_version     = "TLS1_2"

  # Be carful with default_action = "Deny" -> see input parameter documentation
  default_action = "Allow"

  sku                    = "Standard_RAGRS"
  static_website_enabled = true
}

module "storageiplist" {
  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-storage?ref=4.1" 
  name                = "${local.prefix_flat}${local.hash_suffix}ipl"
  location            = module.rg.resource_group_location
  resource_group_name = module.rg.resource_group_name
  min_tls_version     = "TLS1_2"

  public_network_access_enabled  = false
  default_action                 = "Deny"
  storage_public_ip_list_allowed = ["3.64.180.95", "18.159.237.194"]
}
```

### Example usage IN  

```hcl
locals {
  // Subnet id
  subnet_id = "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/BASF_RG_Network_${data.azurerm_subscription.current.display_name}/providers/Microsoft.Network/virtualNetworks/BASF_VN_IN_${data.azurerm_subscription.current.display_name}/subnets/BASF_SN_IN_${data.azurerm_subscription.current.display_name}${var.subnet_intranet_name_suffix}"
  // Webapp Subnet id
  # webapp_subnet_id = "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/BASF_RG_Network_${data.azurerm_subscription.current.display_name}/providers/Microsoft.Network/virtualNetworks/BASF_VN_IN_${data.azurerm_subscription.current.display_name}/subnets/BASF_SN_IN_${data.azurerm_subscription.current.display_name}${var.subnet_webapp_name_suffix}"
}
module "storage" {
  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-storage?ref=4.1" 
  name                             = "${local.prefix_flat}${local.hash_suffix}sa"
  location                         = module.rg.resource_group_location
  resource_group_name              = module.rg.resource_group_name
  cross_tenant_replication_enabled = true

  public_network_access_enabled = false

  allow_nested_items_to_be_public = true
  shared_access_key_enabled       = true
  //containers could not be created via Terraform script due to then extisting network restrictions

}

module "privateendpointstorageblob" {
  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-privateendpoint"

  location            = data.azurerm_virtual_network.vn.location
  resource_group_name = module.rg.resource_group_name
  pe_name             = "${local.prefix_kebab}-${local.hash_suffix}-pendpstorageblob"
  subnet_id           = local.subnet_id
  target_resource     = module.storage.storage_id
  subresource_names   = ["blob"]
}


module "storagefile" {
  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-storage?ref=4.1" 
  name                = "${local.prefix_flat}${local.hash_suffix}saf"
  location            = module.rg.resource_group_location
  resource_group_name = module.rg.resource_group_name


  public_network_access_enabled = false

  allow_nested_items_to_be_public = true
  shared_access_key_enabled       = true
  //files could not be created via Terraform script due to then extisting network restrictions

}

module "privateendpointstoragefile" {
  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-privateendpoint"

  location            = data.azurerm_virtual_network.vn.location
  resource_group_name = module.rg.resource_group_name
  pe_name             = "${local.prefix_kebab}-${local.hash_suffix}-pendpstoragefile"
  subnet_id           = local.subnet_id
  target_resource     = module.storagefile.storage_id
  subresource_names   = ["file"]
}

# Example for hosting Static WebSites in Azure Storage with a Private Endpoint
module "storagestaticwebsite" {
  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-storage?ref=4.1" 
  name                = "${local.prefix_flat}${local.hash_suffix}web"
  location            = module.rg.resource_group_location
  resource_group_name = module.rg.resource_group_name
  min_tls_version     = "TLS1_2"

  public_network_access_enabled   = false
  allow_nested_items_to_be_public = true
  shared_access_key_enabled       = true

  static_website_enabled = true # enable static website

}

module "privateendpointstoragesweb" {
  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-privateendpoint"

  location            = data.azurerm_virtual_network.vn.location
  resource_group_name = module.rg.resource_group_name
  pe_name             = "${local.prefix_kebab}-${local.hash_suffix}-pendpstoragesweb"
  subnet_id           = local.subnet_id
  target_resource     = module.storagestaticwebsite.storage_id
  subresource_names   = ["Web"]
}
```

## Providers

| Name | Version |
|------|---------|
| azurerm | ~>4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_storage_account.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_account_network_rules.storage_network_rules](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account_network_rules) | resource |
| [azurerm_storage_blob.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_blob) | resource |
| [azurerm_storage_container.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_queue.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) | resource |
| [azurerm_storage_share.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share) | resource |
| [azurerm_storage_table.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_table) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_tier | The access tier of the storage account. | `string` | `"Hot"` | no |
| allow\_nested\_items\_to\_be\_public | Allow or disallow nested items within this Account to opt into being public. Defaults to false | `bool` | `false` | no |
| assign\_identity | Set to `true` to enable system-assigned managed identity, or `false` to disable it. | `bool` | `true` | no |
| blob\_properties | Blob properties block | `any` | `null` | no |
| blobs | List of storage blobs. | `list(any)` | `[]` | no |
| containers | List of storage containers. | <pre>list(object({<br/>    name        = string<br/>    access_type = string<br/>  }))</pre> | `[]` | no |
| cross\_tenant\_replication\_enabled | Allow cross tenant replication for blob storage accounts | `bool` | `false` | no |
| default\_action | Specifies the default action of allow or deny when no other rules match. Valid options are Deny or Allow. | `string` | `"Allow"` | no |
| https\_only | Set to `true` to only allow HTTPS traffic, or `false` to disable it. | `bool` | `true` | no |
| is\_hns\_enabled | Is Hierarchical Namespace enabled? | `bool` | `false` | no |
| kind | The kind of storage account. | `string` | `"StorageV2"` | no |
| location | The name of the location. | `string` | `""` | no |
| min\_tls\_version | The minimum supported TLS version for the storage account | `string` | `"TLS1_2"` | no |
| name | The name of the storage account. | `string` | n/a | yes |
| nfsv3\_enabled | Is NFSv3 protocol enabled? Changing this forces a new resource to be created. Defaults to false. | `bool` | `false` | no |
| public\_network\_access\_enabled | Indicates whether the storage account permits requests from public. The default value is true | `bool` | `true` | no |
| queues | List of storages queues. | `list(string)` | `[]` | no |
| resource\_group\_name | The name of an existing resource group. | `string` | n/a | yes |
| shared\_access\_key\_enabled | Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. If false, then all requests, including shared access signatures, must be authorized with Azure Active Directory (Azure AD). The default value is true | `bool` | `true` | no |
| shares | List of storage shares. | <pre>list(object({<br/>    name  = string<br/>    quota = number<br/>  }))</pre> | `[]` | no |
| sku | The SKU of the storage account. | `string` | `"Standard_LRS"` | no |
| static\_website\_enabled | Indicates whether the storage account activates static website hosting. The default value is false. Can only be set when the kind is set to StorageV2 or BlockBlobStorage. | `bool` | `false` | no |
| static\_website\_error\_404\_document | The absolute path to a custom webpage that should be used when a request is made which does not correspond to an existing file. The value is case-sensitive. The default value is error\_404.html. | `string` | `"error_404.html"` | no |
| static\_website\_index\_document | The webpage that Azure Storage serves for requests to the root of a website or any subfolder. For example, index.html. The value is case-sensitive. The default value is index.html. | `string` | `"index.html"` | no |
| storage\_public\_ip\_list\_allowed | List of public IPs from the internet or on-premises-networks which will be granted access to storage account. Only public IPv4 addresses in CIDR format are allowed. | `list(string)` | `[]` | no |
| storage\_vnet\_integration\_subnet\_id | Id of the subnet to associate with the storage | `list(any)` | `[]` | no |
| tables | List of storage tables. | `list(string)` | `[]` | no |
| tags | n/a | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| primary\_blob\_connection\_string | The connection string associated with the primary blob location. |
| primary\_blob\_endpoint | The endpoint URL for blob storage in the primary location. |
| primary\_web\_endpoint | The endpoint URL for web storage in the primary location. |
| primary\_web\_host | The hostname with port if applicable for web storage in the primary location. |
| secondary\_web\_endpoint | The endpoint URL for web storage in the secondary location. |
| secondary\_web\_host | The hostname with port if applicable for web storage in the secondary location. |
| static\_website\_enabled | Indicates whether the storage account activates static website hosting. |
| storage\_containers | Map of containers. |
| storage\_id | The ID of the storage account. |
| storage\_identity\_principal\_id | The Managed Service Identity. |
| storage\_ip\_rules | The IP list of public addresses having access to the storage account. |
| storage\_min\_tls\_version | The minimum supported TLS version for the storage account. |
| storage\_name | The name of the storage account. |
| storage\_primary\_access\_key | The primary access key for the storage account. |
| storage\_primary\_connection\_string | The primary connection string for the storage account. |
| storage\_queues | Map of Queues. |
| storage\_shares | Map of shares. |
| storage\_tables | Map of tables. |
| storage\_virtual\_network\_subnet\_ids | The tupel of the subnet IDs. |

# Change log
## terraform-azurerm-storage Changelog
---
### [4.1](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-storage?version=GT4.1)

#### [4.1.23966](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-storage?version=GT4.1.23966) <small>(2025-04-16 by Jorge Pulido Lopez)</small>
Marked some outputs as sensitive (conflicting with latest terraform versions)

#### Summary
Marked some outputs as sensitive (conflicting with latest terraform versions)


Fixed
  * Marked some outputs as sensitive (conflicting with latest terraform versions)

#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| > 0.14.x          | >~4.0                        |




#### [4.1.22661](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-storage?version=GT4.1.22661) <small>(2025-02-17 by Pablo Casillas)</small>
Add cross tenant attribute

#### Summary

Added cross tenant replication attribute to storage accounts

Changed

Added functionality for replicate storage account between tenants


#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| > 0.14.x          | >= 3.66                            |


#### [4.1.22190](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-storage?version=GT4.1.22190) <small>(2025-01-29 by Felix Brettnich)</small>
Enhance storage module to support public IP list and add corresponding output

#### Summary
Enhance storage module to support public IP list and add corresponding output

#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| >= 0.14          | ~>4.0                           |

---
### [4.0](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-storage?version=GT4.0)

#### [4.0.20503](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-storage?version=GT4.0.20503) <small>(2024-11-13)</small>
_No description provided._

---
### [1.8](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-storage?version=GT1.8)

#### [1.8.20299](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-storage?version=GT1.8.20299) <small>(2024-11-09)</small>
_No description provided._


#### [1.8.20092](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-storage?version=GT1.8.20092) <small>(2024-11-07 by Marius Grosch)</small>
Removed fixed Provider Version

#### Summary
Removed fixed Provider Version

Breaking
  * Removed fixed Provider Version

#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| >= 0.14          | > 3.0                            |

---
### [1.7](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-storage?version=GT1.7)

#### [1.7.20058](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-storage?version=GT1.7.20058) <small>(2024-11-07 by Martin Fabian)</small>
Added additional pipeline parameters

#### Summary
Added additional pipeline parameters

Changed
  * Added additional pipeline parameters




#### [1.7.18439](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-storage?version=GT1.7.18439) <small>(2024-08-30 by Felix Wenzel)</small>
bump patch version

#### Summary
bump patch version

Changed
  * bump patch version

#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| > 0.14.x          | >= 3.66                            |


#### [1.7.18436](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-storage?version=GT1.7.18436) <small>(2024-08-30 by Felix Wenzel)</small>
add shared_access_key_enabled setting

#### Summary
add shared_access_key_enabled setting

Changed
  * add shared_access_key_enabled setting

#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| > 0.14.x          | >= 3.66                            |

add shared_access_key_enabled setting


#### [1.7.18067](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-storage?version=GT1.7.18067) <small>(2024-08-15)</small>
_No description provided._


#### [1.7.18062](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-storage?version=GT1.7.18062) <small>(2024-08-14 by Michael Kroh)</small>
The property `enable_https_traffic_only` has been superseded by `https_traffic_only_enabled`

#### Summary
The property `enable_https_traffic_only` has been superseded by `https_traffic_only_enabled



Changed
  * │ The property `enable_https_traffic_only` has been superseded by
│ `https_traffic_only_enabled` and will be removed in v4.0 of the AzureRM
│ Provider.



#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| > 0.14.x          | >= 3.66                            |


---
### [1.6](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-storage?version=GT1.6)

#### [1.6.18058](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-storage?version=GT1.6.18058) <small>(2024-08-14 by Michael Kroh)</small>
pin to higest azurerm 3.113.0 (July 18, 2024)

#### Summary
pin to max azurerm 3.113.0 (July 18, 2024)



Changed
  * pin to max azurerm 3.113.0 (July 18, 2024) 



#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| > 0.14.x          | <= 3.113.0                       |




#### [1.6.12210](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-storage?version=GT1.6.12210) <small>(2023-11-23 by Daniel Alexander Giej)</small>
Using new pipeline templates

#### Summary
Use of the new pipeline templates


#### [1.6.10527](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-storage?version=GT1.6.10527) <small>(2023-08-28 by Martin Fabian)</small>
Static WebSites capability

#### Summary
Added Static WebSites capability in module terraform-azurerm-storage

Changed
  * static website can be activated
     NOTE: can only be activated when the kind is set to StorageV2 or BlockBlobStorage.


#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| > 0.14.x          | >= 3.66                            |

---
### [1.5](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-storage?version=GT1.5)

#### [1.5.10382](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-storage?version=GT1.5.10382) <small>(2023-08-23)</small>
_No description provided._


#### [1.5.10379](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-storage?version=GT1.5.10379) <small>(2023-08-23 by Martin Fabian)</small>
Change for terraform-docs

#### Summary
Added Terraform-Docs-Section in Readme.md and re-arranged e2e-test for including fixture/main.tf in Readme.md via terraform-docs

#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| > 0.14.x          | >= 3.66                            |


#### [1.5.9533](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-storage?version=GT1.5.9533) <small>(2023-07-21 by Felix Brettnich)</small>
Added pull request template

#### Summary
Added pull request template


# Contributing

When contributing to this repository, please first discuss the change you wish to make via issue,
email, or any other method with the owners of this repository before making a change. 

Please note we have a code of conduct, please follow it in all your interactions with the project.

## Pull Request Process

1. Ensure any install or build dependencies are removed before the end of the layer when doing a 
  build.
2. Update the README.md with details of changes to the interface, this includes new environment 
  variables, exposed ports, useful file locations and container parameters.
3. Increase the version numbers in any examples files and the README.md to the new version that this
  Pull Request would represent. The versioning scheme we use is [SemVer](http://semver.org/).
4. You may merge the Pull Request in once you have the sign-off of two other developers, or if you 
  do not have permission to do that, you may request the second reviewer to merge it for you.

## Code of Conduct

### Our Pledge

In the interest of fostering an open and welcoming environment, we as
contributors and maintainers pledge to making participation in our project and
our community a harassment-free experience for everyone, regardless of age, body
size, disability, ethnicity, gender identity and expression, level of experience,
nationality, personal appearance, race, religion, or sexual identity and
orientation.

### Our Standards

Examples of behavior that contributes to creating a positive environment
include:

* Using welcoming and inclusive language
* Being respectful of differing viewpoints and experiences
* Gracefully accepting constructive criticism
* Focusing on what is best for the community
* Showing empathy towards other community members

Examples of unacceptable behavior by participants include:

* The use of sexualized language or imagery and unwelcome sexual attention or
advances
* Trolling, insulting/derogatory comments, and personal or political attacks
* Public or private harassment
* Publishing others' private information, such as a physical or electronic
  address, without explicit permission
* Other conduct which could reasonably be considered inappropriate in a
  professional setting

### Our Responsibilities

Project maintainers are responsible for clarifying the standards of acceptable
behavior and are expected to take appropriate and fair corrective action in
response to any instances of unacceptable behavior.

Project maintainers have the right and responsibility to remove, edit, or
reject comments, commits, code, wiki edits, issues, and other contributions
that are not aligned to this Code of Conduct, or to ban temporarily or
permanently any contributor for other behaviors that they deem inappropriate,
threatening, offensive, or harmful.

### Scope

This Code of Conduct applies both within project spaces and in public spaces
when an individual is representing the project or its community. Examples of
representing a project or community include using an official project e-mail
address, posting via an official social media account, or acting as an appointed
representative at an online or offline event. Representation of a project may be
further defined and clarified by project maintainers.

### Enforcement

Instances of abusive, harassing, or otherwise unacceptable behavior may be
reported by contacting the project team at [cloud-at-basf@basf.com]. All
complaints will be reviewed and investigated and will result in a response that
is deemed necessary and appropriate to the circumstances. The project team is
obligated to maintain confidentiality with regard to the reporter of an incident.
Further details of specific enforcement policies may be posted separately.

Project maintainers who do not follow or enforce the Code of Conduct in good
faith may face temporary or permanent repercussions as determined by other
members of the project's leadership.

### Attribution

This Code of Conduct is adapted from the [Contributor Covenant][homepage], version 1.4,
available at [http://contributor-covenant.org/version/1/4][version]

[homepage]: http://contributor-covenant.org
[version]: http://contributor-covenant.org/version/1/4/
<!-- END_TF_DOCS -->

## Related documentation

Terraform resource documentation: [registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account)
Microsoft Azure documentation: [docs.microsoft.com/en-us/azure/storage/](https://docs.microsoft.com/en-us/azure/storage/)
Microsoft Azure documentation: [docs.microsoft.com/en-us/azure/storage/common/storage-account-overview](https://docs.microsoft.com/en-us/azure/storage/common/storage-account-overview)
