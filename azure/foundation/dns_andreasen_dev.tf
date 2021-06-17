resource "azurerm_dns_zone" "andreasen_dev" {
  name                = "andreasen.dev"
  resource_group_name = azurerm_resource_group.dns.name
  tags                = local.tags
}

resource "gitlab_group_variable" "AZURE_DNS_ZONE_ID_ANDREASEN_DEV" {
  group         = data.gitlab_group.all_projects.id
  key           = "AZURE_DNS_ZONE_ID_ANDREASEN_DEV"
  variable_type = "env_var"
  value         = azurerm_dns_zone.andreasen_dev.id
  protected     = false
  masked        = false
}

resource "azurerm_dns_txt_record" "protonmail_verification" {
  name                = "@"
  zone_name           = azurerm_dns_zone.andreasen_dev.name
  resource_group_name = azurerm_resource_group.dns.name
  ttl                 = 300

  record {
    value = "protonmail-verification=3739ed01bdfe1fcdb31e46a542c893a7a101a7dc"
  }

  tags = local.tags
}
