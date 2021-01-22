locals {
  dns_zone_reifnir_com                 = data.terraform_remote_state.foundation.outputs.dns_zone_reifnir_com_id
  reifnir_dns_zone_resource_group_name = split("/", local.dns_zone_reifnir_com)[4]
  reifnir_dns_zone_name                = split("/", local.dns_zone_reifnir_com)[8]
  kubernetes_ingress_ip                = data.terraform_remote_state.kubernetes.outputs.ingress_ip
}
