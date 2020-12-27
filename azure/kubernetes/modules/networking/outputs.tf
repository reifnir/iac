output "cluster_vnet_name" {
  description = "Name of the vnet in which all cluster resources will communicate"
  value       = azurerm_virtual_network.kube.name
}

output "worker_subnet" {
  value = azurerm_subnet.worker
}

output "app_gateway_subnet" {
  value = azurerm_subnet.appgw
}
