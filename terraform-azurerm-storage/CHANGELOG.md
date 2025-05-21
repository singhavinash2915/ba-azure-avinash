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

