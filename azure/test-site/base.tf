terraform {
  backend "http" {
    # Relies on environment variables for configuration
  }
}

provider "azurerm" {
  subscription_id = var.azure_subscription
  features {}
}

provider "kubernetes" {
  config_path = var.kube_config_path
}
