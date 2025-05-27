terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.0" # https://www.terraform.io/language/expressions/version-constraints#version-constraints # specify azurerm version if needed
    }
  }
  required_version = ">= 0.14"
}


