terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.111.0"
    }

    azapi = {
      source = "azure/azapi"
    }
  }

}

resource "azurerm_storage_account" "main" {
  name                          = "stbiudwadlsg2${var.env}001"
  location                      = var.location
  resource_group_name           = var.storage_resource_group_name
  account_tier                  = "Standard"
  account_replication_type      = (var.env == "prod" ? "GZRS" : "LRS")
  enable_https_traffic_only     = true
  public_network_access_enabled = false

  network_rules {
    default_action = "Deny"
    bypass         = ["AzureServices"]
  }

  lifecycle {
    ignore_changes = [static_website]
  }

  tags = var.tags
}

locals {
  identifier = "${var.project_name}-${azurerm_storage_account.main.name}"
}

### Private endpoint resources
resource "azurerm_private_endpoint" "storage_main" {
  name                = "pl-${local.identifier}"
  location            = var.location
  resource_group_name = var.storage_resource_group_name
  subnet_id           = var.storage_subnet_id

  private_service_connection {
    name                           = "pec-${local.identifier}"
    private_connection_resource_id = azurerm_storage_account.main.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "dzg-${local.identifier}"
    private_dns_zone_ids = [azurerm_private_dns_zone.storage_main.id]
  }

  tags       = var.tags
  depends_on = [azurerm_storage_account.main]
}

resource "azurerm_private_dns_zone" "storage_main" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = var.network_resource_group_name

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "storage_main" {
  name                  = "vnetlink-${local.identifier}"
  resource_group_name   = var.network_resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.storage_main.name
  virtual_network_id    = var.virtual_network_id

  tags = var.tags
}


provider "azapi" {
  skip_provider_registration = "true"
}

resource "azapi_resource" "containers" {
  type      = "Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01"
  name      = "stbiudwadlsg2${var.env}001"
  parent_id = "${azurerm_storage_account.main.id}/blobServices/default"

  body = {
    properties = {
      publicAccess = false
    }
  }
  schema_validation_enabled = false

}
