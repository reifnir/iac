resource "azurerm_resource_group" "cluster" {
  name     = "rg-${local.name}"
  location = "East US"
}
