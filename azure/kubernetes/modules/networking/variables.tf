variable "name" {
  description = "Slug-name for the root of the cluster"
}

variable "resource_group" {
  description = "Resource group in which all resources will be located"
}

variable "tags" {
  description = "Tags to be applied to resources related to the swarm"
}

# Optional vars
variable "virtual_network_address_prefix" {
  description = "Containers DNS server IP address."
  default     = "10.0.0.0/8"
}

variable "aks_subnet_address_prefix" {
  description = "Containers DNS server IP address."
  default     = "10.0.0.0/16"
}

variable "app_gateway_subnet_address_prefix" {
  description = "Containers DNS server IP address."
  default     = "10.1.0.0/24"
}

variable "aks_subnet_name" {
  description = "AKS Subnet Name."
  default     = "kubesubnet"
}
