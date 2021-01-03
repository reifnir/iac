terraform {
  required_providers {
    azuread = {
      version = "~> 1"
    }
    azurerm = {
      version = "~> 2"
    }
    random = {
      version = "~> 3"
    }
    kubernetes = {
      version = "~> 1"
    }
  }
}

data "azurerm_subscription" "current" {}
