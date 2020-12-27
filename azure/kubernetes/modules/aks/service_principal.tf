locals {
  cluster_service_principal_name = "sp-cluster-${var.name}"
  ingress_service_principal_name = "sp-ingress-${var.name}"
}

data "azurerm_subscription" "current" {}

resource "azuread_application" "sp_cluster" {
  name                       = local.cluster_service_principal_name
  available_to_other_tenants = false
}

resource "azuread_service_principal" "sp_cluster" {
  application_id = azuread_application.sp_cluster.application_id
}

resource "random_password" "password" {
  length  = 32
  special = true
}

resource "azuread_service_principal_password" "sp_cluster" {
  service_principal_id = azuread_service_principal.sp_cluster.id
  value                = random_password.password.result
  end_date_relative    = "17520h" #expire in 2 years
}

resource "azurerm_role_assignment" "contributor" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.sp_cluster.id
}
