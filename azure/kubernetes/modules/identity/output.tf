output "aks_service_principal_app_id" {
  description = "Application ID/Client ID  of the service principal. Used by AKS to manage AKS related resources on Azure like vms, subnets."
  value       = azuread_application.cluster_sp.application_id
}

output "aks_service_principal_client_secret" {
  description = "Secret of the service principal. Used by AKS to manage Azure."
  value       = azuread_service_principal_password.cluster_sp.value
}

output "aks_service_principal_object_id" {
  description = "Object ID of the service principal."
  value       = azuread_service_principal.cluster_sp.id
}

output "resource_group_principal_id" {
  description = "Service principal id that is associated with the resource group"
  value       = azurerm_user_assigned_identity.cluster_rg.principal_id
}
