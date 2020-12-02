# output "cluster" {
#   value = module.aks.cluster
# }

output "egress_ip" {
  value = module.aks.egress_ip
}

output "debug" {
  value = terraform_remote_state.foundation
}
