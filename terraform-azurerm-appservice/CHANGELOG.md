## terraform-azurerm-appservice Changelog
---
### [4.1](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT4.1)

#### [4.1.22370](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT4.1.22370) <small>(2025-02-03 by Felix Brettnich)</small>
Added support for WebDeploy and FTP Basic Authentication options

#### Summary
Added support for WebDeploy and FTP Basic Authentication options

#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| => 0.14          | ~>4.0                            |

---
### [4.0](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT4.0)

#### [4.0.22140](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT4.0.22140) <small>(2025-01-28 by Felix Brettnich)</small>
Fixed cors config

#### Summary
Fixed cors config

#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| >= 0.14          | ~>4.0                            |


#### [4.0.22013](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT4.0.22013) <small>(2025-01-24 by Felix Brettnich)</small>
Fixed auth settings

#### Summary
Fixed auth settings

#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| >= 0.14          | ~>4.0                            |


#### [4.0.21988](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT4.0.21988) <small>(2025-01-21 by Michael Kroh)</small>
update min_tls_version to 1.3

#### Summary
update min_tls_version to 1.3

Breaking
 * client_certificate_exclusion_path is not longer supported with Tls 1.3

Changed
  * update min_tls_version to 1.3


#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| => 0.14          | ~>4.0                            |




#### [4.0.21180](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT4.0.21180) <small>(2024-12-09 by Michael Kroh)</small>
fix e2e tests with sensitive values

#### Summary
fix e2e tests with sensitive values


#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| => 0.14          | ~>4.0                            |




#### [4.0.20472](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT4.0.20472) <small>(2024-11-13)</small>
_No description provided._

---
### [2.8](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.8)

#### [2.8.20293](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.8.20293) <small>(2024-11-09 by Michael Kroh)</small>
fix Firstwave E2E

#### Summary
fix Firstwave E2E


#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| => 0.14.x          | ~>4.0                            |



#### [2.8.20090](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.8.20090) <small>(2024-11-07 by Michael Kroh)</small>
Update to azurerm4

#### Summary
Update to azurerm4

Breaking
  * Update to azurerm4

#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| => 0.14          | >3.45                          |

---
### [2.7](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.7)

#### [2.7.19349](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.7.19349) <small>(2024-10-10)</small>
_No description provided._


#### [2.7.17169](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.7.17169) <small>(2024-07-13 by Martin Fabian)</small>
Added possibillity to adjust environment which variables are related to App Service authentication

#### Summary

Added possibillity to adjust environment variables which are related to App Service authentication

Changed
Added variables and outputs for: 
WEBSITE_AUTH_ENCRYPTION_KEY
By default, the automatically generated key is used as the encryption key. To override, set to a desired key. This is recommended if you want to share tokens or sessions across multiple apps. If specified, it supersedes the MACHINEKEY_DecryptionKey setting.

WEBSITE_AUTH_SIGNING_KEY
By default, the automatically generated key is used as the signing key. To override, set to a desired key. This is recommended if you want to share tokens or sessions across multiple apps. If specified, it supersedes the MACHINEKEY_ValidationKey setting.

See: https://learn.microsoft.com/en-us/azure/app-service/reference-app-settings?tabs=kudu%2Cdotnet#authentication--authorization

#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| > 0.14.x          | ~> 3.45                            |

---
### [2.6](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.6)

#### [2.6.16590](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.6.16590) <small>(2024-06-19 by Michael Kroh)</small>
add ip_restriction_default_action

#### Summary
add ip_restriction_default_action



Changed
  * add ip_restriction_default_action



#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| > 0.14.x          | >= 3.66                            |



---
### [2.5](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.5)

#### [2.5.16585](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.5.16585) <small>(2024-06-19 by Felix Brettnich)</small>
Added default_ip_restrictions_deny

#### Summary
https://github.com/hashicorp/terraform-provider-azurerm/issues/22593

Fixed
  * Default ip_restrictions action

#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| >= 0.14.x          | ~> 3.45                            |


#### [2.5.16573](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.5.16573) <small>(2024-06-19 by Michael Kroh)</small>
pin version to <3.95 to avoid https://github.com/hashicorp/terraform-provider...

#### Summary
pin version to < 3.95 to avoid https://github.com/hashicorp/terraform-provider...

Fixed
  * pin version to < 3.95 to avoid https://github.com/hashicorp/terraform-provider...

#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| > 0.14.x          | < 3.95                         |




#### [2.5.15086](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.5.15086) <small>(2024-04-19 by Martin Fabian)</small>
Process Parameter allowed_audiences correctly

#### Summary
Process Parameter allowed_audiences correctly

Fixed
  * the parmater allowed_audiences is now handled correctly for EasyAuth-V2

#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| > 0.14.x          | ~> 3.46                            |


#### [2.5.13054](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.5.13054) <small>(2024-01-09 by Michael Kroh)</small>
implement health_check_eviction_time_in_min

#### Summary
implement health_check_eviction_time_in_min



Changed
  * health_check_eviction_time_in_min - (Optional) The amount of time in minutes that a node can be unhealthy before being removed from the load balancer. Possible values are between 2 and 10. Only valid in conjunction with health_check_path.


#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| > 0.14.x          | >= 3.66                            |




#### [2.5.11733](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.5.11733) <small>(2023-11-07 by Martin Fabian)</small>
EasyAuthV2 implementation with not EasyAuhtV1 support anymore

#### Summary
Only EasyAuthV2 via variable aad_client_id 

Breaking
  * No EasyAuthV1 anymore supported by module. Only auth_settings_v2 are now passed to submodules -> auth_settings parameter anymore available.


#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| > 0.14.x          | >= 3.45                            |


#### [2.5.11457](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.5.11457) <small>(2023-10-24 by Martin Fabian)</small>
Added Auth_Settings_V2 (EasyAuthV2) to AppService

#### Summary
Added Auth_Settings_V2 capability to AppService

Changed
  * Added Auth_Settings_V2 settings. See https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app#auth_settings_v2 and https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_web_app#auth_settings_v2

#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| > 0.14.x          | >= 3.45                            |

---
### [2.4](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.4)

#### [2.4.11342](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.4.11342) <small>(2023-10-20 by Michael Kroh)</small>
Implement client_certificate_exclusion_paths

#### Summary
Implement client_certificate_exclusion_paths
Changed
  * Implement client_certificate_exclusion_paths


#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| > 0.14.x          | >= 3.66                            |

impelement client_certificate_exclusion_paths


#### [2.4.11324](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.4.11324) <small>(2023-10-17 by Michael Kroh)</small>
Fixing ip_restrictions changes

#### Summary
Fixing ip_restriction changes


Changed
  * added client_certificate_mode parameter

Fixed
  * fixes lifecycle block, that e.g. ip_restriction changes are discovered

#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| > 0.14.x          | >= 3.66                            |


#### [2.4.11115](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.4.11115) <small>(2023-10-06 by Michael Kroh)</small>
Add custom Domain Verification ID

#### Summary
- Add custom Domain Verification ID to outputs

#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| > 0.14.x          | >= 3.66                            |


#### [2.4.11088](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.4.11088) <small>(2023-10-05 by Daniel Schmitt)</small>
Fixed public network access 

#### Summary
* Added new variable for public network access which was introduces by HashiCorp to enable or disable public network access
* Fixed AppService deprecated arguments

#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| > 0.14.x          | >= 3.66                            |

---
### [2.3](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.3)

#### [2.3.10398](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.3.10398) <small>(2023-08-24)</small>
_No description provided._


#### [2.3.10373](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.3.10373) <small>(2023-08-23)</small>
_No description provided._


#### [2.3.10346](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.3.10346) <small>(2023-08-21 by Martin Fabian)</small>
Chages for Terraform-Docs

#### Summary
Added Terraform-Docs-Section in Readme.md and re-arranged e2e-test for including fixture/main.tf in Readme.md via terraform-docs

#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| > 0.14.x          | >= 3.66                            |


#### [2.3.10167](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.3.10167) <small>(2023-08-14 by Michael Kroh)</small>
add app insights settings for Windows ASP

#### Summary
add app insights settings for Windows ASP

Changed
  * add app insights settings for Windows ASP



#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| > 0.14.x          | >= 3.66                            |


#### [2.3.10161](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.3.10161) <small>(2023-08-14 by Michael Kroh)</small>
Fix  key_vault_reference_identity_id

#### Summary
key_vault_reference_identity_id was mssing in main

Fixed
  * key_vault_reference_identity_id was mssing in main

#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| > 0.14.x          | >= 3.66                            |



#### [2.3.9751](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-appservice?version=GT2.3.9751) <small>(2023-07-28 by Felix Brettnich)</small>
Added pull request template

#### Summary
Added pull request template

