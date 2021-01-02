resource "azurerm_kubernetes_cluster" "aks" {
  name                            = var.name
  location                        = var.resource_group.location
  resource_group_name             = var.resource_group.name
  dns_prefix                      = var.name
  kubernetes_version              = var.aks_cluster_version
  api_server_authorized_ip_ranges = []

  default_node_pool {
    name               = "default"
    node_count         = var.aks_node_count
    vm_size            = var.aks_vm_node_size
    vnet_subnet_id     = var.worker_subnet.id
    availability_zones = []
    node_labels        = {}
    node_taints        = []
    tags               = var.tags
  }

  role_based_access_control {
    azure_active_directory {
      managed = true
      # tenant_id only nessary when overriding current tenant ID
      admin_group_object_ids = split(",", var.admin_object_ids)
    }
    enabled = true
  }

  linux_profile {
    admin_username = var.aks_admin_username

    ssh_key {
      key_data = file(var.aks_admin_public_key_path)
    }
  }

  service_principal {
    client_id     = var.aks_service_principal_app_id
    client_secret = var.aks_service_principal_client_secret
  }

  # Using AAD pod identities with the default Kubenet network plugin has a bunch of issues. It's all taken care of with the azure plugin
  # https://azure.github.io/aad-pod-identity/docs/configure/aad_pod_identity_on_kubenet/
  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
  }

  tags = var.tags
}
