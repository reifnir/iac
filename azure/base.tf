terraform {
  # backend "http" {
  #   # Relies on environment variables for configuration
  # }
  required_providers {
    azurerm = {
      version = "~> 2.31"
    }
  }
}

provider "azurerm" {
  features {}
}
