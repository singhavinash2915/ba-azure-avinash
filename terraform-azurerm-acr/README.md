# Azure Container Registry

This Terraform module creates an [Azure Container Registry](https://docs.microsoft.com/en-us/azure/container-registry/).

<!-- BEGIN_TF_DOCS -->
## Usage

This module is optimized to work with the [BASF Terraform Runner](https://docs.cloudreference.basf.com/) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `BASF Terraform Runner` available in the [documentation](https://docs.cloudreference.basf.com/).

### Example usage PI  

```hcl
# For E2E test for this module
module "acr" {
  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-acr?ref=4.0" 
  name                = "${local.prefix_flat}${local.hash_suffix}"
  location            = module.rg.resource_group_location
  resource_group_name = module.rg.resource_group_name
  sku                 = "Standard"
  admin_enabled       = true
}


module "acr_premium" {
  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-acr?ref=4.0" 
  name                = "${local.prefix_flat}${local.hash_suffix}p"
  location            = module.rg.resource_group_location
  resource_group_name = module.rg.resource_group_name
  sku                 = "Premium"
  admin_enabled       = false
  identity = {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.mi_acr.id]
  }
  allowed_cidrs = ["128.246.11.0/24", "40.74.28.0/23", "20.166.41.0/24"] //GPC LU and Azure devops Server Europe
}
```

### Example usage IN  

```hcl
locals {
  subnet_id = "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/BASF_RG_Network_${data.azurerm_subscription.current.display_name}/providers/Microsoft.Network/virtualNetworks/BASF_VN_IN_${data.azurerm_subscription.current.display_name}/subnets/BASF_SN_IN_${data.azurerm_subscription.current.display_name}${var.subnet_intranet_name_suffix}"
}

module "acr" {
  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-acr?ref=4.0" 
  name                          = "${local.prefix_flat}${local.hash_suffix}"
  location                      = module.rg.resource_group_location
  resource_group_name           = module.rg.resource_group_name
  sku                           = "Premium" //only Premius cann disallow public:network_access
  admin_enabled                 = true
  public_network_access_enabled = false
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
| [azurerm_container_registry.registry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| admin\_enabled | Whether the admin user is enabled. | `bool` | `false` | no |
| allowed\_cidrs | List of CIDRs to allow on the registry. | `list(string)` | `[]` | no |
| azure\_services\_bypass\_allowed | Whether to allow trusted Azure services to access a network restricted Container Registry. | `bool` | `false` | no |
| data\_endpoint\_enabled | Whether to enable dedicated data endpoints for this Container Registry? (Only supported on resources with the Premium SKU). | `bool` | `false` | no |
| georeplication\_locations | A list of Azure locations where the Ccontainer Registry should be geo-replicated. Only activated on Premium SKU.<br/>  Supported properties are:<br/>    location                  = string<br/>    zone\_redundancy\_enabled   = bool<br/>    regional\_endpoint\_enabled = bool<br/>    tags                      = map(string)<br/>  or this can be a list of `string` (each element is a location) | `any` | `[]` | no |
| identity | type = object({<br/>  type         = (Required) The type of the Identity. Possible values are `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned`.<br/>  identity\_ids = (Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this ACR.<br/>}) | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string))<br/>  })</pre> | `null` | no |
| location | Azure region to use | `string` | n/a | yes |
| name | Azure Container Registry name | `string` | `""` | no |
| public\_network\_access\_enabled | Whether the Container Registry is accessible publicly. | `bool` | `true` | no |
| resource\_group\_name | Name of the resource group | `string` | n/a | yes |
| retention\_policy\_in\_days | The number of days to retain and untagged manifest after which it gets purged. | `number` | `360` | no |
| sku | The SKU name of the the container registry. Possible values are `Classic` (which was previously `Basic`), `Basic`, `Standard` and `Premium`. | `string` | `"Standard"` | no |
| tags | A map of tags to set on every taggable resources. Empty by default. | `map(string)` | `{}` | no |
| trust\_policy\_enabled | Specifies whether the trust policy is enabled (Premium only). | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| acr\_fqdn | The Container Registry FQDN. |
| acr\_id | The Container Registry ID. |
| acr\_name | The Container Registry name. |
| admin\_password | The Password associated with the Container Registry Admin account - if the admin account is enabled. |
| admin\_username | The Username associated with the Container Registry Admin account - if the admin account is enabled. |
| login\_server | The URL that can be used to log into the container registry. |

# Change log
## terraform-azurerm-acr Changelog
---
### [4.0](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-acr?version=GT4.0)

#### [4.0.20459](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-acr?version=GT4.0.20459) <small>(2024-11-13 by )</small>




---
### [1.1](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-acr?version=GT1.1)

#### [1.1.20269](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-acr?version=GT1.1.20269) <small>(2024-11-09 by )</small>





#### [1.1.20267](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-acr?version=GT1.1.20267) <small>(2024-11-09 by )</small>





#### [1.1.20265](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-acr?version=GT1.1.20265) <small>(2024-11-09 by )</small>





#### [1.1.20263](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-acr?version=GT1.1.20263) <small>(2024-11-09 by )</small>





#### [1.1.20262](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-acr?version=GT1.1.20262) <small>(2024-11-09 by )</small>





#### [1.1.20257](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-acr?version=GT1.1.20257) <small>(2024-11-09 by )</small>





#### [1.1.20254](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-acr?version=GT1.1.20254) <small>(2024-11-09 by )</small>





#### [1.1.20250](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-acr?version=GT1.1.20250) <small>(2024-11-09 by )</small>





#### [1.1.20248](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-acr?version=GT1.1.20248) <small>(2024-11-09 by )</small>





#### [1.1.20247](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-acr?version=GT1.1.20247) <small>(2024-11-09 by )</small>





#### [1.1.20246](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-acr?version=GT1.1.20246) <small>(2024-11-09 by )</small>





#### [1.1.20241](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-acr?version=GT1.1.20241) <small>(2024-11-09 by )</small>





#### [1.1.20240](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-acr?version=GT1.1.20240) <small>(2024-11-09 by )</small>





#### [1.1.20239](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-acr?version=GT1.1.20239) <small>(2024-11-09 by )</small>





#### [1.1.20237](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-acr?version=GT1.1.20237) <small>(2024-11-09 by )</small>





#### [1.1.20236](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-acr?version=GT1.1.20236) <small>(2024-11-09 by )</small>





#### [1.1.20037](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-acr?version=GT1.1.20037) <small>(2024-11-07 by Michael Kroh)</small>
Update to azurerm Version 4 

#### Summary
Update to azurerm Version 4 

Breaking
 * adapt to azurerm v4
  * [azurerm_container_registry](https://cf-registry.tf-registry-prod-use1.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide#azurerm_container_registry)


#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| => 0.14          | >3.0                            |


#### [1.1.18581](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-acr?version=GT1.1.18581) <small>(2024-09-04 by Michael Kroh)</small>
Complete Module with all arguments

#### Summary
Complete Module with all arguments


Changed
  * Complete Module with all arguments



#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| > 0.14.x          | ~> 3.0                           |



---
### [1.0](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-acr?version=GT1.0)

#### [1.0.12147](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-acr?version=GT1.0.12147) <small>(2023-11-22 by Daniel Alexander Giej)</small>
Terraform-Docs adjustments

#### Summary
Adjustment for Terraform-Docs documentation process.



#### [1.0.9514](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-acr?version=GT1.0.9514) <small>(2023-07-21 by Felix Brettnich)</small>
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

Terraform resource documentation: [terraform.io/docs/providers/azurerm/r/container_registry.html](https://www.terraform.io/docs/providers/azurerm/r/container_registry.html)


