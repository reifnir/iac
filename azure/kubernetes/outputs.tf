# output "cluster" {
#   value = module.aks.cluster
# }

output "egress_ip" {
  value = module.aks.egress_ip
}

# data.terraform_remote_state.foundation.outputs.dns_zone_reifnir_com <-- what I want
# output "debug" {
#   value = 
# }
