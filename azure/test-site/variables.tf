variable "azure_subscription" {
  description = "Azure Subscription GUID where managed resources will reside"
}

variable "foundation_state_address" {
  description = "URL where the foundation terraform backend can be found"
}

variable "kubernetes_state_address" {
  description = "URL where the kubernetes terraform backend can be found"
}
