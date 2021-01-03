resource "azuread_application" "cluster_sp" {
  name                       = local.cluster_service_principal_name
  available_to_other_tenants = false
}

resource "azuread_service_principal" "cluster_sp" {
  application_id = azuread_application.cluster_sp.application_id
}

resource "random_password" "cluster_sp" {
  length  = 32
  special = true
}

resource "azuread_service_principal_password" "cluster_sp" {
  service_principal_id = azuread_service_principal.cluster_sp.id
  value                = random_password.cluster_sp.result
  end_date_relative    = "17520h" #expire in 2 years
}

resource "azurerm_role_assignment" "cluster_sp_contributor" {
  # TODO: This scope seems like more than is necessary, get back to this once everything's working
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.cluster_sp.id

  // Waiting for AAD global replication
  provisioner "local-exec" {
    command = "echo \"pwd=$(pwd)\" && ${path.module}/../../../../scripts/wait-for-service-principal-contributor-role-to-propagate.sh ${azuread_service_principal.cluster_sp.id}"
  }
}
