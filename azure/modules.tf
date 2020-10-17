module "aks" {
  source         = "./modules/aks"
  name           = "aks-${local.name}"
  resource_group = azurerm_resource_group.cluster

  aks_cluster_version = "1.19.0"
  aks_node_count      = 2
  aks_vm_node_size    = "Standard_B2s"

  aks_admin_username        = var.aks_admin_username
  aks_admin_public_key_path = var.aks_admin_public_key_path

  tags = local.tags
}

module "gitlab_variables" {
  source = "./modules/gitlab_variables"
  group_id = var.gitlab_group_id
  kubernetes_provider_info = module.aks.kubernetes_provider_info
}
