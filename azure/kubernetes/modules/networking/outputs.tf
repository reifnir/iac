output "worker_subnet" {
  value = azurerm_subnet.worker
}

output "app_gateway_subnet" {
  value = azurerm_subnet.appgw
}
