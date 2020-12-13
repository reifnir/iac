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

provider "azuread" {
}

provider "gitlab" {
  # Instead of setting "token" explicitly, let it load from the GITLAB_TOKEN environment variable
}

provider "kubernetes" {
  # Don't initialize the k8s provider until the cluster exists
  load_config_file       = "false"
  host                   = module.aks.output.kubernetes_provider_info.host
  username               = module.aks.output.kubernetes_provider_info.username
  password               = module.aks.output.kubernetes_provider_info.password
  client_certificate     = base64decode(module.aks.output.kubernetes_provider_info.client_certificate_encoded)
  client_key             = base64decode(module.aks.output.kubernetes_provider_info.client_key_encoded)
  cluster_ca_certificate = base64decode(module.aks.output.kubernetes_provider_info.cluster_ca_certificate_encoded)
}

provider "random" {
}
