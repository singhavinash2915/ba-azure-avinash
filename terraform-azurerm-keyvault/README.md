# Azure Key Vault 

This Terraform module creates an [Azure Key Vault](https://docs.microsoft.com/en-us/azure/key-vault/)
with "reader", "user and "admin" pre-configured [Access policies](https://docs.microsoft.com/en-us/azure/key-vault/key-vault-secure-your-key-vault#data-plane-and-access-policies).

## Hints
The Service Principle, that runs the Pipeline is always granted access

<!-- BEGIN_TF_DOCS -->
## Usage

This module is optimized to work with the [BASF Terraform Runner](https://docs.cloudreference.basf.com/) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `BASF Terraform Runner` available in the [documentation](https://docs.cloudreference.basf.com/).

### Example usage PI  

```hcl
module "keyvault" {
  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-keyvault?ref=4.0" 

  keyvault_name       = "${local.prefix_kebab}-${local.hash_suffix}-kv"
  location            = module.rg.resource_group_location
  resource_group_name = module.rg.resource_group_name

  devopsuser_objects_ids = [
    "7d67bbe4-9903-47d0-96ef-25825be895f3", //admkrohm
    "00c7f1a0-2aab-4cea-9dc6-1089705a7f26"  //admfabianma
  ]

  reader_objects_ids = [
    "340f027b-3d2f-408c-b33e-961e9fe8e627", //Frontdoor
    "4a0b4e9b-0dab-4741-92dc-ee98e7102517"  // WebApp
  ]

}


module "keyvault_kv" {
  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-keyvault?ref=4.0" 

  keyvault_name                 = "k${formatdate("DDMMMYYYYhhmmZZZ", timestamp())}"
  location                      = module.rg.resource_group_location
  resource_group_name           = module.rg.resource_group_name
  public_network_access_enabled = true
  purge_protection_enabled      = true


  user_objects_ids = [
    "7d67bbe4-9903-47d0-96ef-25825be895f3", //admkrohm
    "00c7f1a0-2aab-4cea-9dc6-1089705a7f26"  //admfabianma
  ]

  reader_objects_ids = [
    "340f027b-3d2f-408c-b33e-961e9fe8e627", //Frontdoor
    "4a0b4e9b-0dab-4741-92dc-ee98e7102517"  // WebApp
  ]

}
resource "azurerm_key_vault_key" "kv_key" {

  name         = "kv-key"
  key_vault_id = module.keyvault_kv.key_vault_id
  key_type     = "RSA"
  key_size     = 2048
  key_opts     = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
  rotation_policy {
    automatic {
      time_before_expiry = "P30D"
    }
    notify_before_expiry = "P15D"
    expire_after         = "P180D"
  }
  depends_on = [module.keyvault_kv]

}
```

### Example usage IN  

```hcl
module "keyvault" {
  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-keyvault?ref=4.0" 

  keyvault_name       = "${local.prefix_kebab}-${local.hash_suffix}-kv"
  location            = module.rg.resource_group_location
  resource_group_name = module.rg.resource_group_name

  user_objects_ids = [
    "7d67bbe4-9903-47d0-96ef-25825be895f3", //admkrohm
    "00c7f1a0-2aab-4cea-9dc6-1089705a7f26"  //admfabianma
  ]

  reader_objects_ids = [
    "340f027b-3d2f-408c-b33e-961e9fe8e627", //Frontdoor
    "4a0b4e9b-0dab-4741-92dc-ee98e7102517"  // WebApp
  ]
  public_network_access_enabled = false
  enable_rbac_authorization     = true
}
module "privateendpointkeyvault" {

  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-privateendpoint"

  location            = data.azurerm_virtual_network.vn.location
  resource_group_name = module.rg.resource_group_name
  pe_name             = "${local.prefix_kebab}-${local.hash_suffix}-pendpkeyvault"
  subnet_id           = local.subnet_id
  target_resource     = module.keyvault.key_vault_id
  subresource_names   = ["vault"]
}
```

## Providers

| Name | Version |
|------|---------|
| azurerm | ~> 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault.keyvault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_key_vault_access_policy.admin_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.devopsusers_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.readers_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.service_principle_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.users_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| admin\_objects\_ids | Ids of the objects that can do all operations on all keys, secrets and certificates | `list(string)` | `[]` | no |
| devopsuser\_objects\_ids | Devops Ids of the objects that can do user operations on all keys, secrets and certificates | `list(string)` | `[]` | no |
| enable\_rbac\_authorization | Enable RBAC-based authentication for this key vault and disable policy-based authentication. | `bool` | `false` | no |
| enabled\_for\_deployment | Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. | `bool` | `false` | no |
| enabled\_for\_disk\_encryption | Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. | `bool` | `false` | no |
| enabled\_for\_template\_deployment | Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault. | `bool` | `false` | no |
| keyvault\_name | The Name of the Key Vault. | `string` | n/a | yes |
| location | Azure location for Key Vault. | `string` | n/a | yes |
| network\_acls | Object with attributes: `bypass`, `default_action`, `ip_rules`, `virtual_network_subnet_ids`. See https://www.terraform.io/docs/providers/azurerm/r/key_vault.html#bypass for more informations. | <pre>object({<br/>    bypass                     = optional(string),<br/>    default_action             = optional(string),<br/>    ip_rules                   = optional(list(string)),<br/>    virtual_network_subnet_ids = optional(list(string)),<br/>  })</pre> | `null` | no |
| public\_network\_access\_enabled | Whether public network access is allowed for this Key Vault. Defaults to true | `bool` | `true` | no |
| purge\_protection\_enabled | Whether to activate purge protection | `bool` | `false` | no |
| reader\_objects\_ids | Ids of the objects that can read all keys, secrets and certificates | `list(string)` | `[]` | no |
| resource\_group\_name | Resource Group the resources will belong to | `string` | n/a | yes |
| sku\_name | The Name of the SKU used for this Key Vault. Possible values are "standard" and "premium". | `string` | `"standard"` | no |
| tags | A map of tags to set on every taggable resources. Empty by default. | `map(string)` | `{}` | no |
| user\_objects\_ids | Ids of the objects that can do user operations on all keys, secrets and certificates | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| key\_vault\_id | Id of the Key Vault |
| key\_vault\_name | Name of the Key Vault |
| key\_vault\_uri | URI of the Key Vault |
| service\_principle\_policy\_id | Id of the Service Principle Policy |

# Change log
## terraform-azurerm-keyvault Changelog
---
### [4.0](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-keyvault?version=GT4.0)

#### [4.0.22010](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-keyvault?version=GT4.0.22010) <small>(2025-01-24 by Michael Kroh)</small>
Make network_acls variable fields optional in variables.tf

#### Summary
Make network_acls variable fields optional in variables.tf


Changed
  * Make network_acls variable fields optional in variables.tf



#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| => 0.14           | ~>4.0                              |




#### [4.0.21733](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-keyvault?version=GT4.0.21733) <small>(2025-01-08 by Michael Kroh)</small>
Add E2E Test for Keyvault Key expiration

#### Summary
Add E2E Test for Keyvault Key expiration


Changed
  * Add E2E Test for Keyvault Key expiration


#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| => 0.14           | ~>4.0                              |


#### [4.0.20485](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-keyvault?version=GT4.0.20485) <small>(2024-11-13)</small>
_No description provided._

---
### [1.4](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-keyvault?version=GT1.4)

#### [1.4.20414](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-keyvault?version=GT1.4.20414) <small>(2024-11-11 by Marius Grosch)</small>
Pinned AzureRm Version to ~> 4.0

#### Summary
Pinned AzureRm Version to ~> 4.0

Breaking
  * Pinned AzureRm Version to ~> 4.0

#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| >= 0.14          | ~> 4.0                            |

---
### [1.3](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-keyvault?version=GT1.3)

#### [1.3.19957](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-keyvault?version=GT1.3.19957) <small>(2024-11-06 by Marius Grosch)</small>
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
### [1.2](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-keyvault?version=GT1.2)

#### [1.2.13312](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-keyvault?version=GT1.2.13312) <small>(2024-01-25 by Felix Wenzel)</small>
adding new var to configure enable_rbac_authorization

#### Summary
Add new parameter enable_rbac_authorization

Changed
  * add new parameter for enable_rbac_authorization


#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| > 0.14.x          | >= 3.66                            |

adding new var to configure enable_rbac_authorization


#### [1.2.12151](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-keyvault?version=GT1.2.12151) <small>(2023-11-22 by Daniel Alexander Giej)</small>
Terraform-Doku adjustments

#### Summary
Adjustments to the Terraform documentation process


#### [1.2.9537](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-keyvault?version=GT1.2.9537) <small>(2023-07-21 by Felix Brettnich)</small>
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

Terraform resource documentation: [www.terraform.io/docs/providers/azurerm/r/key_vault.html](https://www.terraform.io/docs/providers/azurerm/r/key_vault.html)
Microsoft Azure documentation: [docs.microsoft.com/en-us/azure/key-vault/](https://docs.microsoft.com/en-us/azure/key-vault/)
