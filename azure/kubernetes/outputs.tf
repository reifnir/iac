output "ingress_ip" {
  description = "Public IP address of the app gateway"
  value = module.ingress.ingress_ip
}

output "egress_ip" {
  value = module.aks.egress_ip
}

# data.terraform_remote_state.foundation.outputs.dns_zone_reifnir_com <-- what I want
# output "debug" {
#   value = 
# }
