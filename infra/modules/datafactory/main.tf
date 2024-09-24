resource "azurerm_data_factory" "main" {
  name                            = "df-${var.project_name}-${var.env}-001"
  location                        = var.location
  resource_group_name             = var.apps_resource_group_name
  managed_virtual_network_enabled = true
  public_network_enabled          = false
  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    ignore_changes = [
      vsts_configuration
    ]
  }

  tags = var.tags
}

locals {
  identifier = "${var.project_name}-${azurerm_data_factory.main.name}"
}

resource "azurerm_data_factory_integration_runtime_azure" "private" {
  name                    = "dfir-${var.project_name}-${var.env}"
  data_factory_id         = azurerm_data_factory.main.id
  location                = var.location
  core_count              = 8
  compute_type            = "General"
  virtual_network_enabled = true
}


### Private endpoint resources
resource "azurerm_private_endpoint" "adf_main" {
  name                = "pl-${local.identifier}"
  location            = var.location
  resource_group_name = var.apps_resource_group_name
  subnet_id           = var.adf_subnet_id

  private_service_connection {
    name                           = "pec-${local.identifier}"
    private_connection_resource_id = azurerm_data_factory.main.id
    subresource_names              = ["dataFactory"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "dzg-${local.identifier}"
    private_dns_zone_ids = [azurerm_private_dns_zone.adf_main.id]
  }

  depends_on = [azurerm_data_factory.main]
  tags       = var.tags
}

resource "azurerm_private_dns_zone" "adf_main" {
  name                = "privatelink.adf.azure.com"
  resource_group_name = var.network_resource_group_name

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "adf_main" {
  name                  = "vnetlink-${local.identifier}"
  resource_group_name   = var.network_resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.adf_main.name
  virtual_network_id    = var.virtual_network_id

  tags = var.tags
}