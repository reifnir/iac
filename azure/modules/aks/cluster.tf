resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.name
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  dns_prefix          = var.name
  kubernetes_version  = var.aks_cluster_version

  default_node_pool {
    name       = "default"
    node_count = var.aks_node_count
    vm_size    = var.aks_vm_node_size
  }

  role_based_access_control {
    enabled = true
  }

  linux_profile {
    admin_username = var.aks_admin_username

    ssh_key {
      key_data = var.aks_admin_ssh_key
    }
  }

  service_principal {
    client_id     = azuread_application.sp.application_id
    client_secret = azuread_service_principal_password.sp.value
  }

  tags = var.tags
}
