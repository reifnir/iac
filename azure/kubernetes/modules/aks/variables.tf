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

variable "app_gateway_subnet" {
  description = "The Azure object for the subnet associated with the App Gateway"
}

variable "tags" {
  description = "Tags to be applied to resources related to the swarm"
}

# As 12/13/2020, Standard_v2 is 8x the cost of Standard_Small per gateway-hour
variable "app_gateway_sku" {
  description = "The Name of the SKU to use for this Application Gateway. Possible values are Standard_Small, Standard_Medium, Standard_Large, Standard_v2, WAF_Medium, WAF_Large, and WAF_v2"
  default     = "Standard_v2"
}

# Note: Not all combinations of sku name and tier are valid. Expect Azure to yell at you during apply
variable "app_gateway_tier" {
  description = "The Tier of the SKU to use for this Application Gateway. Possible values are Standard, Standard_v2, WAF and WAF_v2"
  default     = "Standard_v2"
}
