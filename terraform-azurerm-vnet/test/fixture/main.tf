module "vnet" {
  source = "./../.." # Use the local version to test it

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