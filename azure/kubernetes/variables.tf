variable "kubernetes_version" {
  description = "The version of Kubernetes the cluster will be deployed with. Note: Terraform may replace the cluster if the version changes, so consider upgrading that outside of TF. In order to find available cluster versions, run: `az aks get-versions --location [location]`"
  default     = "1.20.2"
}

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
  default     = "East US"
}

variable "foundation_state_address" {
  description = "URL where the foundation terraform backend can be found"
}

variable "azure_subscription" {
  description = "Azure Subscription GUID where all resources will reside"
}

variable "cluster_admin_object_ids" {
  description = "A comma separated (no spaces) list of Azure Active Directory Object IDs that have admin rights on the cluster."
}
