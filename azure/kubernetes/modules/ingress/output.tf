output "ingress_ip" {
  description = "Public IP address of the app gateway"
  value = azurerm_public_ip.kube.ip_address
}