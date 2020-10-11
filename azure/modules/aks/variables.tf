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

variable "aks_admin_ssh_key_path" {
  description = "An ssh_key block. Only one is currently allowed. Changing this forces a new resource to be created"
}

variable "tags" {
  description = "Tags to be applied to resources related to the swarm"
}
