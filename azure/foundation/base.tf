terraform {
  backend "http" {
    # Relies on environment variables for configuration
  }
}

provider "azurerm" {
  subscription_id = var.azure_subscription
  features {}
}

resource "azurerm_resource_group" "dns" {
  name     = "rg-dns-zones"
  location = var.location
  tags     = local.tags
}
