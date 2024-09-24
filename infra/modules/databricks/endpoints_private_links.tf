### Private endpoint resources
locals {
  identifier = "${var.project_name}-${var.env}"
}

resource "azurerm_private_endpoint" "adb_auth" {
  name                = "pl-${local.identifier}-adbauth"
  location            = var.location
  resource_group_name = var.apps_resource_group_name
  subnet_id           = var.adbtransit_subnet_id

  private_service_connection {
    name                           = "pec-${local.identifier}-adbauth"
    private_connection_resource_id = azurerm_databricks_workspace.main.id
    subresource_names              = ["browser_authentication"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "dzg-${local.identifier}-adbauth"
    private_dns_zone_ids = [azurerm_private_dns_zone.adb_main.id]
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "adb_uiapi" {
  name                = "pl-${local.identifier}-uiapi"
  location            = var.location
  resource_group_name = var.apps_resource_group_name
  subnet_id           = var.adbtransit_subnet_id

  private_service_connection {
    name                           = "pec-${local.identifier}-uiapi"
    private_connection_resource_id = azurerm_databricks_workspace.main.id
    subresource_names              = ["databricks_ui_api"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "dzg-${local.identifier}-uiapi"
    private_dns_zone_ids = [azurerm_private_dns_zone.adb_main.id]
  }

  tags       = var.tags
  depends_on = [azurerm_private_endpoint.adb_auth]
}

resource "azurerm_private_dns_zone" "adb_main" {
  name                = "privatelink.azuredatabricks.net"
  resource_group_name = var.network_resource_group_name

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "adb_main" {
  name                  = "vnetlink-${local.identifier}"
  resource_group_name   = var.network_resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.adb_main.name
  virtual_network_id    = var.virtual_network_id

  tags = var.tags
}
