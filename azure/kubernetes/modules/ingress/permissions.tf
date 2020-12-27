resource "azurerm_role_assignment" "agic_sp_contributor" {
  scope                = azurerm_application_gateway.network.id
  role_definition_name = "Contributor"
  principal_id         = var.resource_group_principal_id # azurerm_user_assigned_identity.cluster_rg.principal_id
  depends_on           = [azurerm_application_gateway.network]
}

resource "azurerm_role_assignment" "agic_sp_reader" {
  scope                = var.resource_group.id
  role_definition_name = "Reader"
  principal_id         = var.resource_group_principal_id # azurerm_user_assigned_identity.cluster_rg.principal_id
  depends_on           = [azurerm_application_gateway.network]
}
