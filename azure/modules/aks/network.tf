# # User Assigned Idntities
# resource "azurerm_user_assigned_identity" "testIdentity" {
#   resource_group_name = var.resource_group.name
#   location            = var.resource_group.location

#   name = "identity1"

#   tags = var.tags
# }

locals {
  vnet_name               = "vnet-${var.name}"
  app_gateway_subnet_name = "appgwsubnet"
}

resource "azurerm_virtual_network" "kube" {
  name                = local.vnet_name
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  address_space       = [var.virtual_network_address_prefix]

  # subnet {
  #   name           = var.aks_subnet_name
  #   address_prefix = var.aks_subnet_address_prefix # Kubernetes Subnet Address prefix
  # }

  # subnet {
  #   name           = local.app_gateway_subnet_name # Has to be hardcoded to this name.
  #   address_prefix = var.app_gateway_subnet_address_prefix
  # }

  tags = var.tags
}

resource "azurerm_subnet" "kubesubnet" {
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

# Public IP
resource "azurerm_public_ip" "kube" {
  name                = "default_pip"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = var.tags
}
