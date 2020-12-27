terraform {
  required_providers {
    azurerm = {
      version = "~> 2"
    }
  }
}

data "azurerm_subscription" "current" {}
