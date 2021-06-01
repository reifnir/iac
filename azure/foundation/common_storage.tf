resource "azurerm_resource_group" "common_storage" {
  name     = "rg-common-storage"
  location = var.location
  tags     = local.tags
}

# azurerm_storage_account.common will be destroyed
resource "azurerm_storage_account" "common" {
  name                = "sareifnircommonstorage"
  resource_group_name = azurerm_resource_group.common_storage.name
  location            = var.location

  account_replication_type = "LRS"
  account_tier             = "Standard"
  min_tls_version          = "TLS1_2"

  tags = local.tags
}

resource "azurerm_storage_container" "terraform_state" {
  name                 = "terraform-state"
  storage_account_name = "sareifnircommonstorage"
}
