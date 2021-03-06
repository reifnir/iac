module "networking" {
  source         = "./modules/networking"
  name           = local.name
  resource_group = azurerm_resource_group.cluster
  tags           = local.tags
}

module "identity" {
  source = "./modules/identity"
  name   = local.name

  resource_group        = azurerm_resource_group.cluster
  cluster_vnet_name     = module.networking.cluster_vnet_name
  worker_subnet_id      = module.networking.worker_subnet.id
  container_registry_id = data.terraform_remote_state.foundation.outputs.container_registry_id

  # Terraform threw an error without this hint to wait for the RG to be created
  depends_on = [azurerm_resource_group.cluster]
  tags       = local.tags

}

module "aks" {
  # Cluster metadata
  source           = "./modules/aks"
  name             = local.name
  resource_group   = azurerm_resource_group.cluster
  admin_object_ids = var.cluster_admin_object_ids

  # Cluster config
  aks_cluster_version = var.kubernetes_version
  # Having only one node isn't a great idea, but trying to keep costs under $150. This is the cheapest option for now
  # aks_node_count   = 1
  # aks_vm_node_size = "Standard_B2s"

  aks_node_count   = 2
  aks_vm_node_size = "Standard_A8_v2"


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
  source                  = "./modules/ingress"
  name                    = local.name
  resource_group          = azurerm_resource_group.cluster
  resource_group_identity = module.identity.resource_group_identity

  # Networking
  app_gateway_subnet = module.networking.app_gateway_subnet

  # Ingress (We don't need autoscaling and we don't want to pay 8x as much for the app gateway)
  app_gateway_sku  = "WAF_v2"
  app_gateway_tier = "WAF_v2"

  tags = local.tags
}

module "gitlab_variables" {
  source                   = "./modules/gitlab_variables"
  group_id                 = var.gitlab_group_id
  kubernetes_provider_info = module.aks.kubernetes_provider_info
  kube_config_admin        = module.aks.kube_config_admin
}
