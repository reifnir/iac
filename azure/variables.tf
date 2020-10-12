variable "aks_admin_username" {
  description = "The Admin Username for the Cluster. Changing this forces a new resource to be created"
}

variable "aks_admin_public_key_path" {
  description = "An ssh_key block. Only one is currently allowed. Changing this forces a new resource to be created"
}

# variable "gitlab_token" {
#   description = "This is the GitLab personal access token. It must be provided, but it can also be sourced from the GITLAB_TOKEN environment variable"  
# }

variable "gitlab_group_id" {
  description = "Group ID that GitLab variables will be saved to"
}
