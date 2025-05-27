# Azure Application Insights

This Terraform module creates an [Application Insights](https://docs.microsoft.com/en-us/azure/azure-monitor/app/app-insights-overview)
component.

## Limitations

* n/a

<!-- BEGIN_TF_DOCS -->
## Usage

This module is optimized to work with the [BASF Terraform Runner](https://docs.cloudreference.basf.com/) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `BASF Terraform Runner` available in the [documentation](https://docs.cloudreference.basf.com/).

### Example usage PI  

```hcl
module "app_insights" {
  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appinsights?ref=4.0" 
  app_insights_name   = "${local.prefix_kebab}-${local.hash_suffix}"
  location            = module.rg.resource_group_location
  resource_group_name = module.rg.resource_group_name
  application_type    = "web"
}

resource "azurerm_monitor_diagnostic_setting" "app_insights_azurerm_monitor_diagnostic_setting" {
  name                       = "${local.prefix_kebab}-${local.hash_suffix}-ai-mon"
  target_resource_id         = module.app_insights.application_insights_id
  log_analytics_workspace_id = module.app_insights.log_analytics_workspace_id

  enabled_log {
    category = "AppAvailabilityResults"
  }
  enabled_log {
    category = "AppBrowserTimings"
  }
  enabled_log {
    category = "AppEvents"
  }
  enabled_log {
    category = "AppMetrics"
  }
  enabled_log {
    category = "AppDependencies"
  }
  enabled_log {
    category = "AppExceptions"
  }
  enabled_log {
    category = "AppPageViews"
  }
  enabled_log {
    category = "AppPerformanceCounters"
  }
  enabled_log {
    category = "AppRequests"
  }
  enabled_log {
    category = "AppSystemEvents"
  }
  enabled_log {
    category = "apptraces"
  }

  metric {
    category = "AllMetrics"
  }
}

module "app_insights_sa" {
  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appinsights?ref=4.0" 
  app_insights_name           = "${local.prefix_kebab}-${local.hash_suffix}-withsa"
  location                    = module.rg.resource_group_location
  resource_group_name         = module.rg.resource_group_name
  application_type            = "web"
  createloganalytigsworkspace = false
  createstorageaccount        = true
}

resource "azurerm_monitor_diagnostic_setting" "app_insights_sa_azurerm_monitor_diagnostic_setting" {
  name               = "${local.prefix_kebab}-${local.hash_suffix}-ai-mon"
  target_resource_id = module.app_insights_sa.application_insights_id
  storage_account_id = module.app_insights_sa.storage_account_id

  enabled_log {
    category = "AppAvailabilityResults"
  }
  enabled_log {
    category = "AppBrowserTimings"
  }
  enabled_log {
    category = "AppEvents"
  }
  enabled_log {
    category = "AppMetrics"
  }
  enabled_log {
    category = "AppDependencies"
  }
  enabled_log {
    category = "AppExceptions"
  }
  enabled_log {
    category = "AppPageViews"
  }
  enabled_log {
    category = "AppPerformanceCounters"
  }
  enabled_log {
    category = "AppRequests"
  }
  enabled_log {
    category = "AppSystemEvents"
  }
  enabled_log {
    category = "apptraces"
  }

  metric {
    category = "AllMetrics"
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
| [azurerm_application_insights.app_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) | resource |
| [azurerm_log_analytics_workspace.la](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_storage_account.logsa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_client_config.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_subscription.current_subscription](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| app\_insights\_name | Application Insights Name | `string` | `""` | no |
| application\_type | Application type for Application Insights resource Valid values are ios for iOS, java for Java web, MobileCenter for App Center, Node.JS for Node.js, other for General, phone for Windows Phone, store for Windows Store and web for ASP.NET. Please note these values are case sensitive; unmatched values are treated as ASP.NET by Azure. | `string` | `"other"` | no |
| createloganalytigsworkspace | Create Log Analytics Workspace where Diagnostics Data can be sent. You have to specify azurerm\_monitor\_diagnostic\_setting resource to send data to Log Analytics Workspace. | `bool` | `true` | no |
| createstorageaccount | Create Storage Account where logs can be sent. You have to specify azurerm\_monitor\_diagnostic\_setting resource to send data to Storage Account. | `bool` | `false` | no |
| location | Azure location. | `string` | n/a | yes |
| resource\_group\_name | Resource group name | `string` | n/a | yes |
| retention\_in\_days | Specifies the retention period in days of the Log Analytics Workspace. Possible values are 30, 60, 90, 120, 180, 270, 365, 550 or 730. Defaults to 30 | `number` | `30` | no |
| sku | Specifies the SKU of the Log Analytics Workspace. Possible values are Free, PerNode, Premium, Standard, Standalone, Unlimited, CapacityReservation, and PerGB2018 (new SKU as of 2018-04-03). Defaults to PerGB2018. | `string` | `"PerGB2018"` | no |
| storage\_account\_replication\_type | Specifies the type of replication to use for log storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS. Defaults to LRS. | `string` | `"LRS"` | no |
| storage\_account\_tier | Specifies the Tier to use for this storage account. Valid options are Standard and Premium. Defaults to Standard. | `string` | `"Standard"` | no |
| tags | A map of tags to set on every taggable resources. Empty by default. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| application\_insights\_app\_id | The App ID associated with this Application Insights component. |
| application\_insights\_connection\_string | Connection string of the Application Insights associated to the App Service |
| application\_insights\_id | The ID of the Application Insights component. |
| application\_insights\_instrumentation\_key | Instrumentation key of the Application Insights associated to the App Service |
| log\_analytics\_workspace\_id | The Log Analytics Workspace ID. |
| log\_analytics\_workspace\_primary\_shared\_key | The Primary shared key for the Log Analytics Workspace. |
| log\_analytics\_workspace\_secondary\_shared\_key | The Secondary shared key for the Log Analytics Workspace. |
| storage\_account\_id | The Storage Account ID. |
| storage\_account\_name | The Storage Account Name. |
| storage\_account\_primary\_access\_key | The Primary Access Key for the Storage Account. |
| storage\_account\_primary\_connection\_string | The Primary Connection String for the Storage Account. |
| storage\_account\_secondary\_access\_key | The Secondary Access Key for the Storage Account. |
| storage\_account\_secondary\_connection\_string | The Secondary Connection String for the Storage Account. |

# Change log
## terraform-azurerm-appinsights Changelog
---
### [4.0](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appinsights?version=GT4.0)

#### [4.0.20460](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appinsights?version=GT4.0.20460) <small>(2024-11-13 by )</small>




---
### [1.4](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appinsights?version=GT1.4)

#### [1.4.20273](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appinsights?version=GT1.4.20273) <small>(2024-11-09 by )</small>





#### [1.4.19927](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appinsights?version=GT1.4.19927) <small>(2024-11-06 by Marius Grosch)</small>
Removed fixed provider version

#### Summary
Removed fixed provider version

Breaking
  * Removed fixed provider version



#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| => 0.14          | > 3.0                            |

---
### [1.3](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appinsights?version=GT1.3)

#### [1.3.11958](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appinsights?version=GT1.3.11958) <small>(2023-11-17 by Martin Fabian)</small>
Added option to create a Storage Account

#### Summary
Added the option to create a storage account to wrtie Logs to

#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| > 0.14.x          |                            |

---
### [1.2](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appinsights?version=GT1.2)

#### [1.2.11934](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appinsights?version=GT1.2.11934) <small>(2023-11-15 by Martin Fabian)</small>
Possiblity to prevent Log Analytics Workspace creation

#### Summary
Added possiblity to prevent Log Analytics Workspace creation

Changed
  * Added possiblity to prevent Log Analytics Workspace creation

#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| > 0.14.x          |                             |


#### [1.2.11724](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appinsights?version=GT1.2.11724) <small>(2023-11-07 by Martin Fabian)</small>
Added Outputs for Log Analytics Workspace and adjusted E2E-Tests

#### Summary
Added Outputs for Log Analytics Workspace and adjusted E2E-Tests

Changed
  * Added Outputs for Log Analytics Workspace and adjusted E2E-Tests. Added additional input variables.

#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| > 0.14.x          | >= 2.59                            |

---
### [1.1](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appinsights?version=GT1.1)

#### [1.1.9746](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appinsights?version=GT1.1.9746) <small>(2023-07-28 by Felix Brettnich)</small>
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

Terraform resource documentation: [https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights)

Microsoft Azure documentation: [https://docs.microsoft.com/de-de/azure/azure-monitor/app/app-insights-overview](https://docs.microsoft.com/de-de/azure/azure-monitor/app/app-insights-overview)

