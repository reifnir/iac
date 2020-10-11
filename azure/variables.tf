variable "aks_admin_username" {
  description = "The Admin Username for the Cluster. Changing this forces a new resource to be created"
}

variable "aks_admin_ssh_key" {
  description = "An ssh_key block. Only one is currently allowed. Changing this forces a new resource to be created"
}
