resource "azurerm_resource_group" "acr" {
  name     = "rg-container-registry"
  location = var.location
  tags     = local.tags
}

resource "azurerm_container_registry" "reifnir" {
  name                = "acrreifnir"
  resource_group_name = azurerm_resource_group.acr.name
  location            = azurerm_resource_group.acr.location
  sku                 = "Basic"
  admin_enabled       = false
  tags                = local.tags
}
