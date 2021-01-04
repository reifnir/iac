resource "azurerm_dns_a_record" "test_reifnir_com" {
  name                = "test"
  zone_name           = local.reifnir_dns_zone_name
  resource_group_name = local.reifnir_dns_zone_resource_group_name
  ttl                 = 60
  records             = [local.kubernetes_ingress_ip]
}
