module "networking" {
  source         = "./modules/networking"
  name           = local.name
  resource_group = azurerm_resource_group.cluster
  tags           = local.tags
}

module "aks" {
  # Cluster metadata
  source         = "./modules/aks"
  name           = local.name
  resource_group = azurerm_resource_group.cluster

  # Cluster config
  aks_cluster_version = "1.19.0"
  aks_node_count      = 2
  aks_vm_node_size    = "Standard_B2s"

  # Linux VM config
  aks_admin_username        = var.aks_admin_username
  aks_admin_public_key_path = var.aks_admin_public_key_path

  # Networking
  worker_subnet      = module.networking.worker_subnet
  app_gateway_subnet = module.networking.app_gateway_subnet

  tags = local.tags
}

module "gitlab_variables" {
  source                   = "./modules/gitlab_variables"
  group_id                 = var.gitlab_group_id
  kubernetes_provider_info = module.aks.kubernetes_provider_info
}
