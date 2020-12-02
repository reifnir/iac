variable "aks_admin_username" {
  description = "The Admin Username for the Cluster. Changing this forces a new resource to be created"
}

variable "aks_admin_public_key_path" {
  description = "An ssh_key block. Only one is currently allowed. Changing this forces a new resource to be created"
}

variable "gitlab_group_id" {
  description = "Group ID that GitLab variables will be saved to"
}

variable "location" {
  description = "The default Azure Region"
  default = "East US"
}