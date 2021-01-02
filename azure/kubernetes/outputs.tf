output "ingress_ip" {
  description = "Public IP address of the app gateway"
  value       = module.ingress.ingress_ip
}

output "egress_ip" {
  description = "Public IP from which outgoing traffic appears to come from the cluster."
  value       = module.aks.egress_ip
}

# Don't leave this in. It's just for debugging...
# output "cluster_debug" {
#   description = "This is entirely too much information to be throwing around everywhere. Do not check-in with this in place..."
#   value       = module.aks.cluster
# }

# data.terraform_remote_state.foundation.outputs.dns_zone_reifnir_com <-- what I want
# output "debug" {
#   value = 
# }
