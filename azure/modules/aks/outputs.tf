# output "cluster" {
#   value = azurerm_kubernetes_cluster.aks
# }

# Information needed in order for other modules to initialize a kubernetes provider
# output "kubernetes_provider_info" {
#   value = {
#     host                           = azurerm_kubernetes_cluster.aks.kube_config.0.host
#     username                       = azurerm_kubernetes_cluster.aks.kube_config.0.username
#     password                       = azurerm_kubernetes_cluster.aks.kube_config.0.password
#     client_certificate_encoded     = azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate
#     client_key_encoded             = azurerm_kubernetes_cluster.aks.kube_config.0.client_key
#     cluster_ca_certificate_encoded = azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate
#   }
# }
