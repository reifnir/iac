variable "name" {
  description = "Slug-name for the root of the cluster"
}

variable "resource_group" {
  description = "Resource group in which all resources will be located"
}

variable "resource_group_principal_id" {
  description = "Service principal id that is associated with the resource group"
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

variable "app_gateway_subnet" {
  description = "The Azure object for the subnet associated with the App Gateway"
}

variable "tags" {
  description = "Tags to be applied to resources related to the swarm"
}
