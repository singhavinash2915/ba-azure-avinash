# Azure App Service Plan
This Terraform module creates an [Azure App Service Plan](https://docs.microsoft.com/en-us/azure/app-service/overview-hosting-plans)
with default SKU capacity sets to "2" for dedicated plans.

<!-- BEGIN_TF_DOCS -->
## Usage

This module is optimized to work with the [BASF Terraform Runner](https://docs.cloudreference.basf.com/) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `BASF Terraform Runner` available in the [documentation](https://docs.cloudreference.basf.com/).

### Example usage PI  

```hcl
module "app_service_plan" {
  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-asp?ref=4.0" 

  app_service_plan_name = "${local.prefix_kebab}-${local.hash_suffix}-asp"
  location              = module.rg.resource_group_location
  resource_group_name   = module.rg.resource_group_name
  os_type               = "Linux"
  sku_name              = "B2"


}
module "app_service_plancomp" {
  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-asp?ref=4.0" 

  app_service_plan_name = "${local.prefix_kebab}-${local.hash_suffix}-aspc"
  location              = module.rgcomp.resource_group_location
  resource_group_name   = module.rgcomp.resource_group_name

  kind = "Linux"
  sku = {
    tier = "PremiumV2"
    size = "P1v2"
  }
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
| [azurerm_service_plan.plan](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| app\_service\_environment\_id | The ID of the App Service Environment to create this Service Plan in. Requires an Isolated SKU. Use one of I1, I2, I3 for azurerm\_app\_service\_environment, or I1v2, I2v2, I3v2 for azurerm\_app\_service\_environment\_v3 | `string` | `null` | no |
| app\_service\_plan\_name | The Name of the App Service Plan . | `string` | `null` | no |
| kind | The kind of the App Service Plan to create. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service_plan.html#kind | `string` | `""` | no |
| location | Azure location. | `string` | n/a | yes |
| maximum\_elastic\_worker\_count | The maximum number of workers to use in an Elastic SKU Plan. Cannot be set unless using an Elastic SKU. | `number` | `null` | no |
| os\_type | The O/S type for the App Services to be hosted in this plan. Possible values include `Windows`, `Linux`, and `WindowsContainer`. | `string` | `""` | no |
| per\_site\_scaling\_enabled | Should Per Site Scaling be enabled. | `bool` | `false` | no |
| resource\_group\_name | Resource group name | `string` | n/a | yes |
| sku | A sku block. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service_plan.html#sku | `map(string)` | `{}` | no |
| sku\_name | The SKU for the plan. Possible values include B1, B2, B3, D1, F1, FREE, I1, I2, I3, I1v2, I2v2, I3v2, P1v2, P2v2, P3v2, P1v3, P2v3, P3v3, S1, S2, S3, SHARED, Y1, EP1, EP2, EP3, WS1, WS2, and WS3. | `string` | `""` | no |
| tags | Extra tags to add | `map(string)` | `{}` | no |
| worker\_count | The number of Workers (instances) to be allocated. | `number` | `1` | no |

## Outputs

| Name | Description |
|------|-------------|
| app\_service\_plan\_id | Id of the created App Service Plan |
| app\_service\_plan\_kind | Kind of App Service Plan |
| app\_service\_plan\_location | Azure location of the created App Service Plan |
| app\_service\_plan\_name | Name of the created App Service Plan |

# Change log
## terraform-azurerm-asp Changelog
---
### [4.0](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-asp?version=GT4.0)

#### [4.0.20461](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-asp?version=GT4.0.20461) <small>(2024-11-13 by )</small>




---
### [1.2](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-asp?version=GT1.2)

#### [1.2.20272](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-asp?version=GT1.2.20272) <small>(2024-11-09 by )</small>





#### [1.2.19930](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-asp?version=GT1.2.19930) <small>(2024-11-06 by Marius Grosch)</small>
Removed fixed Provider Version

#### Summary
Removed fixed Provider Version

Breaking
  * Removed fixed Provider Version

#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| >= 0.14          | > 3.0                           |

---
### [1.1](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-asp?version=GT1.1)

#### [1.1.12149](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-asp?version=GT1.1.12149) <small>(2023-11-22 by Daniel Alexander Giej)</small>
Terraform-Doku adjustments

#### Summary
Adjustments to the Terraform Documentation process


#### [1.1.9742](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-asp?version=GT1.1.9742) <small>(2023-07-28 by Felix Brettnich)</small>
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

Terraform resource documentation: [www.terraform.io/docs/providers/azurerm/r/app_service_plan.html](https://www.terraform.io/docs/providers/azurerm/r/app_service_plan.html)
Microsoft Azure documentation: [docs.microsoft.com/en-us/azure/app-service/overview-hosting-plans](https://docs.microsoft.com/en-us/azure/app-service/overview-hosting-plans)
