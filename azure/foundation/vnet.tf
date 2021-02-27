resource "azurerm_resource_group" "vnet" {
  name     = "rg-vnet-shared"
  location = var.location
  tags     = local.tags
}

resource "azurerm_virtual_network" "shared" {
  name                = "vnet-shared"
  location            = azurerm_resource_group.vnet.location
  resource_group_name = azurerm_resource_group.vnet.name
  address_space       = ["10.1.0.0/16"]

  tags = local.tags
}
