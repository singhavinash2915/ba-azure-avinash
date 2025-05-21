# Azure App Service - Linux Container Web App

This Terraform module creates an [Azure App Service Web (Linux container)](https://docs.microsoft.com/en-us/azure/app-service/overview)

## Limitations

* Diagnostics logs only works fine for Windows for now.
* Untested with App Service slots.
* Using a single certificate file on multiple domains with the `custom_domains` variable is not supported. Use a Key Vault certificate instead.

<!-- BEGIN_TF_DOCS -->
## Usage

This module is optimized to work with the [BASF Terraform Runner](https://docs.cloudreference.basf.com/) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `BASF Terraform Runner` available in the [documentation](https://docs.cloudreference.basf.com/).

## Providers

| Name | Version |
|------|---------|
| azurerm | n/a |
| random | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_app_service_certificate.app_service_certificate](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_certificate) | resource |
| [azurerm_app_service_certificate_binding.app_cert_binding](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_certificate_binding) | resource |
| [azurerm_app_service_custom_hostname_binding.app_service_custom_hostname_binding](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_custom_hostname_binding) | resource |
| [azurerm_app_service_custom_hostname_binding.app_service_custom_hostname_binding_azure](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_custom_hostname_binding) | resource |
| [azurerm_app_service_managed_certificate.app_managed_certificate](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_managed_certificate) | resource |
| [azurerm_linux_web_app.app_service_linux_container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app) | resource |
| [azurerm_linux_web_app_slot.app_service_linux_container_slot](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app_slot) | resource |
| [random_bytes.WEBSITE_AUTH_ENCRYPTION_KEY](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/bytes) | resource |
| [random_bytes.WEBSITE_AUTH_SIGNING_KEY](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/bytes) | resource |
| [azurerm_client_config.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_subscription.current_subscription](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aad\_client\_id | This is the Client ID for the AzureAD Application to authenticate via AAD | `string` | `null` | no |
| allowed\_audiences | allowed\_audiences for  the AzureAD Application to authenticate via AAD | `list(string)` | `[]` | no |
| app\_service\_name | AppService name | `string` | n/a | yes |
| app\_service\_vnet\_integration\_subnet\_id | Id of the subnet to associate with the app service | `string` | `null` | no |
| app\_settings | Application settings for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#app_settings | `map(string)` | `{}` | no |
| application\_insights\_connection\_string | Connection string of the Application Insights to use. | `string` | `null` | no |
| application\_insights\_enabled | DOES NOT EFFECT ANYTHING Use Application Insights for this App Service | `bool` | `true` | no |
| application\_insights\_instrumentation\_key | Instrumentaion key of the existing Application Insights to use. | `string` | `null` | no |
| auth\_settings\_v2 | Authentication settings V2. See https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app#auth_settings_v2 | `any` | `{}` | no |
| authorized\_ips | IPs restriction for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#ip_restriction | `list(string)` | `[]` | no |
| authorized\_service\_tags | Service Tags restriction for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#ip_restriction | `list(string)` | `[]` | no |
| authorized\_subnet\_ids | Subnets restriction for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#ip_restriction | `list(string)` | `[]` | no |
| authorized\_x\_azure\_fdid | Frontdoor ID for Header Restriction | `list(string)` | `[]` | no |
| backup\_custom\_name | Custom name for backup | `string` | `null` | no |
| backup\_enabled | `true` to enable App Service backup | `bool` | `false` | no |
| backup\_frequency\_interval | Frequency interval for the App Service backup. | `number` | `1` | no |
| backup\_frequency\_unit | Frequency unit for the App Service backup. Possible values are `Day` or `Hour`. | `string` | `"Day"` | no |
| backup\_keep\_at\_least\_one\_backup | Should the service keep at least one backup, regardless of age of backup. | `bool` | `true` | no |
| backup\_retention\_period\_in\_days | Retention in days for the App Service backup. | `number` | `30` | no |
| backup\_storage\_account\_container | Name of the container in the Storage Account if App Service backup is enabled | `string` | `"webapps"` | no |
| backup\_storage\_account\_name | Storage account name to use if App Service backup is enabled. | `string` | `null` | no |
| backup\_storage\_account\_rg | Storage account resource group to use if App Service backup is enabled. | `string` | `null` | no |
| client\_affinity\_enabled | Client affinity activation for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#client_affinity_enabled | `bool` | `false` | no |
| client\_certificate\_enabled | Client certificate activation for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#client_certificate_enabled | `bool` | `false` | no |
| client\_certificate\_exclusion\_paths | (Optional) Paths to exclude when using client certificates, separated by ;. | `string` | `null` | no |
| client\_certificate\_mode | (Optional) The Client Certificate mode. Possible values are `Required`, `Optional`, and `OptionalInteractiveUser`. This property has no effect when client\_certificate\_enabled is false. | `string` | `null` | no |
| connection\_strings | Connection strings for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#connection_string | `list(map(string))` | `[]` | no |
| custom\_domains | Custom domains and SSL certificates of the App Service. Could declare a custom domain with SSL binding. SSL certificate could be provided from an Azure Keyvault Certificate Secret or from a file. | `map(map(string))` | `null` | no |
| custom\_domains\_azure | Custom domains and SSL certificates of the App Service. Could declare a custom domain with SSL binding. SSL certificate provided from  Azure | `map(map(string))` | `null` | no |
| docker\_image | Docker image to use for this App Service | <pre>object({<br/>    name = string<br/>  })</pre> | n/a | yes |
| docker\_port | The value of the expected container port number. | `string` | `"8080"` | no |
| docker\_registry\_password | The container registry password. | `string` | `null` | no |
| docker\_registry\_url | The container registry url. | `string` | `null` | no |
| docker\_registry\_username | The container registry username. | `string` | `null` | no |
| enable\_storage | Mount an SMB share to the `/home/` directory. | `string` | `"false"` | no |
| ftp\_publish\_basic\_authentication\_enabled | Should the default FTP Basic Authentication publishing profile be enabled. | `bool` | `false` | no |
| https\_only | HTTPS restriction for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#https_only | `bool` | `true` | no |
| identity\_ids | UserAssigned Identities ID to add to App Service. Mandatory if type is UserAssigned | `list(string)` | `null` | no |
| identity\_type | Add an Identity (MSI) to the App Service. Possible values are SystemAssigned or UserAssigned | `string` | `"SystemAssigned"` | no |
| ip\_restriction\_default\_action | The Default action for traffic that does not match any ip\_restriction rule. possible values include Allow and Deny. Defaults to Allow. | `string` | `"Allow"` | no |
| ip\_restriction\_headers | IPs restriction headers for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#headers | `map(list(string))` | `null` | no |
| key\_vault\_reference\_identity\_id | The User Assigned Identity Id used for looking up KeyVault secrets. The identity must be assigned to the application. | `string` | `null` | no |
| location | Azure location. | `string` | n/a | yes |
| mount\_points | Storage Account mount points. Name is generated if not set and default type is AzureFiles. See https://www.terraform.io/docs/providers/azurerm/r/app_service.html#storage_account | `list(map(string))` | `[]` | no |
| public\_network\_access\_enabled | Enables or disables the public network access | `bool` | `true` | no |
| resource\_group\_name | Resource group name | `string` | n/a | yes |
| scm\_authorized\_ips | SCM IPs restriction for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#scm_ip_restriction | `list(string)` | `[]` | no |
| scm\_authorized\_service\_tags | SCM Service Tags restriction for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#scm_ip_restriction | `list(string)` | `[]` | no |
| scm\_authorized\_subnet\_ids | SCM subnets restriction for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#scm_ip_restriction | `list(string)` | `[]` | no |
| scm\_ip\_restriction\_headers | IPs restriction headers for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#headers | `map(list(string))` | `null` | no |
| service\_plan\_id | ID of the Service Plan that hosts the App Service | `string` | n/a | yes |
| site\_config | Site config for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#site_config. IP restriction attribute is no more managed in this block. | `any` | `{}` | no |
| staging\_slot\_custom\_app\_settings | Override staging slot with custom app settings | `map(string)` | `null` | no |
| staging\_slot\_custom\_name | Custom name of the app service slot | `string` | `null` | no |
| staging\_slot\_enabled | Create a staging slot alongside the app service for blue/green deployment purposes. See documentation https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_slot | `bool` | `true` | no |
| start\_time\_limit | Configure the amount of time (in seconds) the app service will wait before it restarts the container. (max 230) | `number` | `120` | no |
| tags | A map of tags to set on every taggable resources. Empty by default. | `map(string)` | `{}` | no |
| webdeploy\_publish\_basic\_authentication\_enabled | Should the default WebDeploy Basic Authentication publishing credentials enabled. | `bool` | `false` | no |
| website\_auth\_encryption\_key | The encryption key used for cookie encryption. See https://learn.microsoft.com/en-us/azure/app-service/reference-app-settings?tabs=kudu%2Cdotnet#authentication--authorization | `string` | `null` | no |
| website\_auth\_signing\_key | The signing key used for cookie signing. See https://learn.microsoft.com/en-us/azure/app-service/reference-app-settings?tabs=kudu%2Cdotnet#authentication--authorization | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| app\_service\_custom\_domain\_verification\_id | The identifier used by App Service to perform domain ownership verification via DNS TXT record. |
| app\_service\_default\_site\_hostname | The Default Hostname associated with the App Service |
| app\_service\_id | Id of the App Service |
| app\_service\_identity\_service\_principal\_id | Id of the Service principal identity of the App Service |
| app\_service\_name | Name of the App Service |
| app\_service\_outbound\_ip\_addresses | Outbound IP adresses of the App Service |
| app\_service\_possible\_outbound\_ip\_addresses | Possible outbound IP adresses of the App Service |
| app\_service\_site\_credential | Site credential block of the App Service |
| app\_service\_slot\_identity\_service\_principal\_id | Id of the Service principal identity of the App Service slot |
| app\_service\_slot\_name | Name of the App Service slot |
| service\_plan\_id | ID of the Service Plan |
| website\_auth\_encryption\_key | The encryption key used for cookie encryption. See https://learn.microsoft.com/en-us/azure/app-service/reference-app-settings?tabs=kudu%2Cdotnet#authentication--authorization |
| website\_auth\_signing\_key | The signing key used for cookie signing. See https://learn.microsoft.com/en-us/azure/app-service/reference-app-settings?tabs=kudu%2Cdotnet#authentication--authorization |

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

Microsoft Azure documentation: [docs.microsoft.com/en-us/azure/app-service/overview](https://docs.microsoft.com/en-us/azure/app-service/overview)
