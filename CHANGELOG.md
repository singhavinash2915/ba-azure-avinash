## terraform-azurerm-vnet Changelog
---
### [4.1](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-vnet?version=GT4.1)

#### [4.1.20862](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-vnet?version=GT4.1.20862) <small>(2024-11-29 by Marius Grosch)</small>
NSG assignment during subnet creation

#### Summary
To stay compliant with the new security policy we have to create subnets and theirs NSGs directly with the vnet resource

Changed
  * To stay compliant with the new security policy we have to create subnets and theirs NSGs directly with the vnet resource

#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| >= 0.14          | ~> 4.0                            |

---
### [4.0](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-vnet?version=GT4.0)

#### [4.0.20505](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-vnet?version=GT4.0.20505) <small>(2024-11-13 by )</small>




---
### [2.4](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-vnet?version=GT2.4)

#### [2.4.20270](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-vnet?version=GT2.4.20270) <small>(2024-11-09 by )</small>





#### [2.4.19934](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-vnet?version=GT2.4.19934) <small>(2024-11-06 by Felix Brettnich)</small>
Fixed subnet arguments

#### Summary
Fixed subnet arguments

Fixed
  * Fixed subnet arguments

#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| >= 0.14          | >3.0                            |

---
### [2.3](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-vnet?version=GT2.3)

#### [2.3.19908](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-vnet?version=GT2.3.19908) <small>(2024-11-06 by Felix Brettnich)</small>
Added NSG for all subnets

#### Summary
Added NSG for all subnets

Changed
  * Added empty NSG for all subnets
  * Updated NSG name

#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| >= 0.14          | ~>3.0                            |


#### [2.3.19166](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-vnet?version=GT2.3.19166) <small>(2024-10-04 by Michael Kroh)</small>
fix error from missing provider definition

#### Summary
fix error from missing provider definition


Changed
  * fix error from missing provider definition


#### Version compatibility

| Terraform version | hashicorp/azurerm provider version |
|-------------------| ---------------------------------- |
| > 0.14.x          | ~>3.0                            |




#### [2.3.12211](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-vnet?version=GT2.3.12211) <small>(2023-11-23 by Daniel Alexander Giej)</small>
Terraform-Doku adjustments

#### Summary
Adjustments to the Terraform documentation process


#### [2.3.9792](https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-vnet?version=GT2.3.9792) <small>(2023-07-28 by Felix Brettnich)</small>
Added pull request template

#### Summary
Added pull request template

