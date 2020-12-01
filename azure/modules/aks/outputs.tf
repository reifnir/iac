output "cluster" {
  value = azurerm_kubernetes_cluster.aks
}

# Information needed in order for other modules to initialize a kubernetes provider
output "kubernetes_provider_info" {
  value = {
    host                           = azurerm_kubernetes_cluster.aks.kube_config.0.host
    username                       = azurerm_kubernetes_cluster.aks.kube_config.0.username
    password                       = azurerm_kubernetes_cluster.aks.kube_config.0.password
    client_certificate_encoded     = azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate
    client_key_encoded             = azurerm_kubernetes_cluster.aks.kube_config.0.client_key
    cluster_ca_certificate_encoded = azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate
  }
}

locals {
  # Essentially, we're taking the GUID that trails the final forward slash character
  # Don't comment what the code is already doing... unless there's regex :)
  regex_guid_pattern = "[0-9a-f-]+$"
  egress_pip_name = regex(local.regex_guid_pattern, tolist(azurerm_kubernetes_cluster.aks.network_profile.0.load_balancer_profile.0.effective_outbound_ips).0)
}

# TODO: add test that blows up when there is more than one outbound ip address (how would that happen?)
data "azurerm_public_ip" "egress" {
  name                = local.egress_pip_name
  resource_group_name = azurerm_kubernetes_cluster.aks.node_resource_group
}

output "egress_ip" {
  value = data.azurerm_public_ip.egress.ip_address
}
