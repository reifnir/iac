# User Assigned Identity for the resoruce group
resource "azurerm_user_assigned_identity" "cluster_rg" {
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location

  name = "rg-identity-${var.name}"
  tags = var.tags
}

data "azurerm_virtual_network" "cluster" {
  name                = var.cluster_vnet_name
  resource_group_name = var.resource_group.name
}

resource "azurerm_role_assignment" "agic_sp_network_contributor" {
  scope                = var.worker_subnet_id
  role_definition_name = "Network Contributor"
  principal_id         = azuread_service_principal.cluster_sp.id

  depends_on = [data.azurerm_virtual_network.cluster]
}

resource "azurerm_role_assignment" "agic_sp_managed_identity_operator" {
  scope                = azurerm_user_assigned_identity.cluster_rg.id
  role_definition_name = "Managed Identity Operator"
  principal_id         = azuread_service_principal.cluster_sp.id
  depends_on           = [azurerm_user_assigned_identity.cluster_rg]
}
