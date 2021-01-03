output "ingress_ip" {
  description = "Public IP address of the app gateway"
  value       = azurerm_public_ip.kube.ip_address
}

output "app_gateway_ingress_controller_info" {
  description = "Contains all variable information needed for configuring AGIC helm package"
  value = {
    subscriptionId       = data.azurerm_subscription.current.subscription_id
    resource_group       = var.resource_group.name
    app_gateway_name     = local.app_gateway_name
    identity_resource_id = var.resource_group_identity.id
    identity_client_id   = var.resource_group_identity.client_id
    debug_entire_sp      = var.resource_group_identity
  }
}
