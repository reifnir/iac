terraform {
  backend "http" {
    # Relies on environment variables for configuration
  }
  required_providers {
    azuread = {
      version = "~> 1.0"
    }
    azurerm = {
      version = "~> 2.31"
    }
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "~> 3.0"
    }
    random = {
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "azuread" {
}

provider "gitlab" {
  token = var.gitlab_token
}

# provider "kubernetes" {
#   # Don't initialize the k8s provider until the cluster exists
#   load_config_file       = "false"
#   host                   = module.aks.outputs.kubernetes_provider_info.host
#   username               = module.aks.outputs.kubernetes_provider_info.username
#   password               = module.aks.outputs.kubernetes_provider_info.password
#   client_certificate     = base64decode(module.aks.outputs.kubernetes_provider_info.client_certificate_encoded)
#   client_key             = base64decode(module.aks.outputs.kubernetes_provider_info.client_key_encoded)
#   cluster_ca_certificate = base64decode(module.aks.outputs.kubernetes_provider_info.cluster_ca_certificate_encoded)
# }

provider "random" {
}
