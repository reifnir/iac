terraform {
  backend "http" {
    # Relies on environment variables for configuration
  }
  required_providers {
    azurerm = {
      version = "~> 2.31"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "dns" {
  name     = "rg-dns-zones"
  location = var.location
  tags     = local.tags
}
