# Azure Virtual Network with optional Subnet 

This module creates a [Virtual Network](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-networks-overview together with a [Virtual Network Subnet](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-network-manage-subnet).

<!-- BEGIN_TF_DOCS -->
## Usage

This module is optimized to work with the [BASF Terraform Runner](https://docs.cloudreference.basf.com/) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `BASF Terraform Runner` available in the [documentation](https://docs.cloudreference.basf.com/).

### Example usage PI  

```hcl
module "vnet" {
  source = "git::https://dev.azure.com/BASFTerraform/TerraformRegistry/_git/terraform-azurerm-vnet?ref=4.1" 

  vnet_name           = "${local.prefix_kebab}-${local.hash_suffix}-vnet"
  location            = module.rg.resource_group_location
  resource_group_name = module.rg.resource_group_name
  vnet_cidr           = ["10.0.0.0/20"]

  subnets = {
    subnet_backend = {
      subnet_address_prefix = ["10.0.1.0/24"]
      service_endpoints     = ["Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.Sql", "Microsoft.Web"]
      rules = [
        {
          name                   = "http"
          priority               = "200"
          direction              = "Inbound"
          access                 = "Allow"
          protocol               = "tcp"
          destination_port_range = "8080"
          description            = "description-myhttp"
          source_address_prefix  = "*"
        },
        {
          name                   = "myssh"
          priority               = "220"
          direction              = "Inbound"
          access                 = "Allow"
          protocol               = "Tcp"
          destination_port_range = "22"
          description            = "description-myssh"
          source_address_prefix  = "128.246.11.0/24"
        }
      ]
    },
    subnet_frontend = {
      subnet_address_prefix = ["10.0.2.0/24"]
      service_endpoints     = ["Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.Sql", "Microsoft.Web"]
    },
    subnet_management = {
      subnet_address_prefix = ["10.0.3.0/24"]
      service_endpoints     = ["Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.Sql", "Microsoft.Web"]
      rules = [
        {
          name                   = "other_ssh"
          priority               = "120"
          direction              = "Inbound"
          access                 = "Allow"
          protocol               = "Tcp"
          destination_port_range = "22"
          description            = "description-myssh"
          source_address_prefix  = "128.246.11.0/24"
        },
        {
          name                    = "other_ssh1"
          priority                = "121"
          direction               = "Inbound"
          access                  = "Allow"
          protocol                = "Tcp"
          destination_port_range  = "22"
          description             = "description-myssh1"
          source_address_prefixes = ["212.202.156.96/28", "212.60.196.176/28", "78.94.196.104/29"]
        }
      ]
    }
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
| [azurerm_network_security_group.nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.nsg_rules](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| dns\_servers | List of IP addresses of DNS servers | `list(string)` | `[]` | no |
| location | Azure region to use | `string` | n/a | yes |
| resource\_group\_name | Resource group name | `string` | n/a | yes |
| subnets | For each subnet, create an object that contain fields | `map` | `{}` | no |
| tags | tags to add | `map(string)` | `{}` | no |
| vnet\_cidr | The address space that is used by the virtual network | `list(string)` | n/a | yes |
| vnet\_name | Name of the Vnet | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| named\_subnet\_ids | Map of subnet resources |
| network\_security\_group\_ids | List of Network security group id |
| network\_security\_group\_names | List of Network security group name |
| subnet\_address\_prefixes | List of address prefix for subnets |
| subnet\_ids | List of IDs of subnets |
| subnet\_names | Names of the created subnets |
| virtual\_network\_id | Virtual network generated id |
| virtual\_network\_location | Virtual network location |
| virtual\_network\_name | Virtual network name |
| virtual\_network\_space | Virtual network space |

# Change log
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

Terraform resource documentation: [terraform.io/docs/providers/azurerm/r/virtual_network.html](https://www.terraform.io/docs/providers/azurerm/r/virtual_network.html)
Microsoft Azure documentation: [docs.microsoft.com/en-us/azure/virtual-network/virtual-networks-overview](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-networks-overview)
Terraform resource documentation: [terraform.io/docs/providers/azurerm/r/subnet.html](https://www.terraform.io/docs/providers/azurerm/r/subnet.html)
Microsoft Azure documentation: [docs.microsoft.com/en-us/azure/virtual-network/virtual-network-manage-subnet](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-network-manage-subnet)
