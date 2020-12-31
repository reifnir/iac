variable "name" {
  description = "Slug-name for the root of the cluster"
}

variable "resource_group" {
  description = "Resource group in which all resources will be located"
}

variable "aks_cluster_version" {
  description = "Kubernetes version"
}

variable "aks_node_count" {
  description = "Number of nodes in the cluster"
}

variable "aks_vm_node_size" {
  description = "Azure VM size. Ex: 'Standard_B2s'"
}

variable "aks_admin_username" {
  description = "The Admin Username for the Cluster. Changing this forces a new resource to be created"
}

variable "aks_admin_public_key_path" {
  description = "An ssh_key block. Only one is currently allowed. Changing this forces a new resource to be created"
}

variable "worker_subnet" {
  description = "The Azure object for the subnet from which nodepools run"
}

variable "aks_service_principal_app_id" {
  description = "Application ID/Client ID  of the service principal. Used by AKS to manage AKS related resources on Azure like vms, subnets."
}

variable "aks_service_principal_client_secret" {
  description = "Secret of the service principal. Used by AKS to manage Azure."
}

variable "aks_service_principal_object_id" {
  description = "Object ID of the service principal."
}

variable "tags" {
  description = "Tags to be applied to resources related to the swarm"
}

variable "admin_object_ids" {
  description = "A comma separated (no spaces) list of Azure Active Directory Object IDs that have admin rights on the cluster."
}
