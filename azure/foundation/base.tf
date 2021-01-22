terraform {
  backend "http" {
    # Relies on environment variables for configuration
  }
  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
    }
  }
}

provider "azurerm" {
  subscription_id = var.azure_subscription
  features {}
}

provider "gitlab" {
  # Instead of setting "token" explicitly, let it load from the GITLAB_TOKEN environment variable
}
