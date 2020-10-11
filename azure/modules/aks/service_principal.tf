data "azurerm_subscription" "current" {}

resource "azuread_application" "sp" {
  name                       = local.service_provider_name
  available_to_other_tenants = false
}

resource "azuread_service_principal" "sp" {
  application_id = azuread_application.sp.application_id
}

resource "random_password" "password" {
  length  = 32
  special = true
}

resource "azuread_service_principal_password" "sp" {
  service_principal_id = azuread_service_principal.sp.id
  value                = random_password.password.result
  end_date_relative    = "17520h" #expire in 2 years
}

resource "azurerm_role_assignment" "contributor" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.sp.id
}
