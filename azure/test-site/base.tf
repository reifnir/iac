terraform {
  backend "http" {
    # Relies on environment variables for configuration
  }
  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  subscription_id = var.azure_subscription
  features {}
}

provider "kubernetes" {
}
