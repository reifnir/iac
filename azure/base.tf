terraform {
  # backend "http" {
  #   # Relies on environment variables for configuration
  # }
  required_providers {
    azuread = {
      version = "1.0.0"
    }
    azurerm = {
      version = "~> 2.31"
    }
  }
}

provider "azurerm" {
  features {}
}
provider "azuread" {
}