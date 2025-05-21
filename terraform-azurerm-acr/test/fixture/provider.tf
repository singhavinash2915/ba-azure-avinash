terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
  required_version = ">= 0.14"
}

provider "azurerm" {
  # Configuration options
  # See https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
  # https://github.com/terraform-providers/terraform-provider-azurerm
  features {
  }
}
