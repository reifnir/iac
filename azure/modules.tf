module "cluster" {
  source         = "./modules/aks"
  name           = "personal-aks"
  resource_group = azurerm_resource_group.cluster

  aks_cluster_version = "1.19.0"
  aks_node_count      = 1
  aks_vm_node_size    = "Standard_B2s"

  aks_admin_username = var.aks_admin_username
  aks_admin_ssh_key  = var.aks_admin_ssh_key

  tags = local.tags
}
