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
}

resource "azurerm_dns_zone" "reifnir_com" {
  name = "reifnir.com"
  resource_group_name = azurerm_resource_group.dns.name
}

output "reifnir_com" {
  value = azurerm_dns_zone.reifnir_com
}
