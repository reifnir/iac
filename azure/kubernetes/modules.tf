module "networking" {
  source         = "./modules/networking"
  name           = local.name
  resource_group = azurerm_resource_group.cluster
  tags           = local.tags
}

module "identity" {
  source = "./modules/identity"
  name   = local.name

  resource_group    = azurerm_resource_group.cluster
  cluster_vnet_name = module.networking.cluster_vnet_name
  worker_subnet_id  = module.networking.worker_subnet.id

  # Terraform threw an error without this hint to wait for the RG to be created
  depends_on = [ azurerm_resource_group.cluster ]
  tags = local.tags

}

module "aks" {
  # Cluster metadata
  source         = "./modules/aks"
  name           = local.name
  resource_group = azurerm_resource_group.cluster

  # Cluster config
  aks_cluster_version = "1.19.3"
  # Having only one node isn't a great idea, but trying to keep costs under $150 for now
  aks_node_count   = 1
  aks_vm_node_size = "Standard_B2s"

  # Identity
  aks_service_principal_app_id        = module.identity.aks_service_principal_app_id
  aks_service_principal_client_secret = module.identity.aks_service_principal_client_secret
  aks_service_principal_object_id     = module.identity.aks_service_principal_object_id

  # Linux VM config
  aks_admin_username        = var.aks_admin_username
  aks_admin_public_key_path = var.aks_admin_public_key_path

  # Networking
  worker_subnet = module.networking.worker_subnet

  tags = local.tags
}

module "ingress" {
  # Cluster metadata
  source                      = "./modules/ingress"
  name                        = local.name
  resource_group              = azurerm_resource_group.cluster
  resource_group_principal_id = module.identity.resource_group_principal_id

  # Networking
  app_gateway_subnet = module.networking.app_gateway_subnet

  # Ingress (We don't need autoscaling and we don't want to pay 8x as much for the app gateway)
  app_gateway_sku  = "Standard_Small"
  app_gateway_tier = "Standard"

  tags = local.tags
}

module "gitlab_variables" {
  source                   = "./modules/gitlab_variables"
  group_id                 = var.gitlab_group_id
  kubernetes_provider_info = module.aks.kubernetes_provider_info
}
