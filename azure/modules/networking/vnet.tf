locals {
  vnet_name               = "vnet-${var.name}"
  app_gateway_subnet_name = "appgwsubnet"
}

resource "azurerm_virtual_network" "kube" {
  name                = local.vnet_name
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  address_space       = [var.virtual_network_address_prefix]

  tags = var.tags
}

resource "azurerm_subnet" "worker" {
  name                 = var.aks_subnet_name
  virtual_network_name = azurerm_virtual_network.kube.name
  resource_group_name  = var.resource_group.name
  address_prefixes     = [var.aks_subnet_address_prefix]
}

resource "azurerm_subnet" "appgw" {
  name                 = local.app_gateway_subnet_name #Hardcoded to this name.
  virtual_network_name = azurerm_virtual_network.kube.name
  resource_group_name  = var.resource_group.name
  address_prefixes     = [var.app_gateway_subnet_address_prefix]
}
