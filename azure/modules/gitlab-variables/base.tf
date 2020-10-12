terraform {
  required_providers {
    azurerm = {
      version = "~> 2.31"
    }
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "~> 3.0"
    }    
  }
}