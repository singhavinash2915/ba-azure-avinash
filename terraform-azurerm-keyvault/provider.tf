terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0" # specify azurerm version if needed

    }
  }
  required_version = ">= 0.14"
}