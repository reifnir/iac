locals {
  app_gateway_name               = "ag-shared"
  backend_address_pool_name      = "${local.app_gateway_name}-beap"
  frontend_port_name             = "${local.app_gateway_name}-feport"
  frontend_ip_configuration_name = "${local.app_gateway_name}-feip"
  http_setting_name              = "${local.app_gateway_name}-be-htst"
  listener_name                  = "${local.app_gateway_name}-httplstn"
  request_routing_rule_name      = "${local.app_gateway_name}-rqrt"

  #networkContributorRole         = "[concat('/subscriptions/', subscription().subscriptionId, '/providers/Microsoft.Authorization/roleDefinitions/', '4d97b98b-1d4f-4787-a291-c67834d212e7')]"
}

resource "azurerm_resource_group" "ag" {
  name     = "rg-app-gateway-shared"
  location = var.location
  tags     = local.tags
}

resource "azurerm_subnet" "ag" {
  name                 = "appgateway"
  virtual_network_name = azurerm_virtual_network.shared.name
  resource_group_name  = azurerm_resource_group.ag.name
  address_prefixes     = ["10.1.250.0/24"]
}

# Public IP
resource "azurerm_public_ip" "ag" {
  name                = "ag-pip"
  location            = azurerm_resource_group.ag.location
  resource_group_name = azurerm_resource_group.ag.name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = local.tags
}

resource "azurerm_application_gateway" "shared" {
  name                = local.app_gateway_name
  resource_group_name = azurerm_resource_group.ag.name
  location            = azurerm_resource_group.ag.location

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "appGatewayIpConfig"
    subnet_id = azurerm_subnet.ag.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_port {
    name = "httpsPort"
    port = 443
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.ag.id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 1
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }

  tags = local.tags
}
