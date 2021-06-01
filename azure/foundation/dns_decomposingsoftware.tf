resource "azurerm_dns_zone" "decomposingsoftware_com" {
  name                = "decomposingsoftware.com"
  resource_group_name = azurerm_resource_group.dns.name
  tags                = local.tags
}

resource "gitlab_group_variable" "AZURE_DNS_ZONE_ID_DECOMPOSINGSOFTWARE_COM" {
  group         = data.gitlab_group.all_projects.id
  key           = "AZURE_DNS_ZONE_ID_DECOMPOSINGSOFTWARE_COM"
  variable_type = "env_var"
  value         = azurerm_dns_zone.decomposingsoftware_com.id
  protected     = false
  masked        = false
}
