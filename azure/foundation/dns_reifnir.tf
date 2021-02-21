resource "azurerm_resource_group" "dns" {
  name     = "rg-dns-zones"
  location = var.location
  tags     = local.tags
}

resource "azurerm_dns_zone" "reifnir_com" {
  name                = "reifnir.com"
  resource_group_name = azurerm_resource_group.dns.name
  tags                = local.tags
}

resource "azurerm_dns_mx_record" "google_apps" {
  zone_name           = azurerm_dns_zone.reifnir_com.name
  resource_group_name = azurerm_resource_group.dns.name
  ttl                 = 60

  record {
    preference = 1
    exchange   = "ASPMX.L.GOOGLE.COM"
  }

  record {
    preference = 5
    exchange   = "ALT1.ASPMX.L.GOOGLE.COM"
  }

  record {
    preference = 5
    exchange   = "ALT2.ASPMX.L.GOOGLE.COM"
  }

  record {
    preference = 10
    exchange   = "ASPMX2.GOOGLEMAIL.COM"
  }

  record {
    preference = 10
    exchange   = "ASPMX3.GOOGLEMAIL.COM"
  }

  tags = local.tags
}

resource "gitlab_group_variable" "AZURE_DNS_ZONE_ID_REIFNIR_COM" {
  group         = data.gitlab_group.all_projects.id
  key           = "AZURE_DNS_ZONE_ID_REIFNIR_COM"
  variable_type = "env_var"
  value         = azurerm_dns_zone.reifnir_com.id
  protected     = false
  masked        = false
}
