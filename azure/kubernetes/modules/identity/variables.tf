variable "name" {
  description = "Slug-name for the root of the cluster"
}

variable "cluster_vnet_name" {
  description = "Name of the vnet in which all cluster resources will communicate"
}

variable "resource_group" {
  description = "Resource group in which all resources will be located"
}

variable "worker_subnet_id" {
  description = "Subnet in which the cluster workers are networked"
}

variable "tags" {
  description = "Tags to be applied to resources related to the swarm"
}
