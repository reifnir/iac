variable "group_id" {
  description = "Group ID that GitLab variables will be saved to"
}

variable "kubernetes_provider_info" {
  description = "All of the info that is required to later stand-up a Terraform kubernetes provider by other projects"
}

variable "kube_config_admin" {
  description = "Raw output of a kube config profile with admin privileges"
}
