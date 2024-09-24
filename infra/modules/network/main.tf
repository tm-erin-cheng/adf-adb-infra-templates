resource "azurerm_resource_group" "apps" {
  name     = var.apps_resource_group_name
  location = var.location
  tags     = var.tags
}
resource "azurerm_resource_group" "data" {
  name     = var.data_resource_group_name
  location = var.location
  tags     = var.tags
}
resource "azurerm_resource_group" "network" {
  name     = var.network_resource_group_name
  location = var.location
  tags     = var.tags
}
resource "azurerm_resource_group" "storage" {
  name     = var.storage_resource_group_name
  location = var.location
  tags     = var.tags
}
resource "azurerm_virtual_network" "main" {
  name                = "vnet-${var.project_name}-${var.location}-${var.env}-001"
  address_space       = [var.vnet_address_space]
  location            = var.location
  resource_group_name = azurerm_resource_group.network.name

  tags = var.tags
}
resource "azurerm_subnet" "storage_private_endpoint" {
  name                              = "snet-${var.project_name}-storage-${var.location}-${var.env}-001"
  resource_group_name               = azurerm_resource_group.network.name
  virtual_network_name              = azurerm_virtual_network.main.name
  address_prefixes                  = [var.storage_subnet_address_space]
  private_endpoint_network_policies = "Disabled"
}

resource "azurerm_subnet" "adf_private_endpoint" {
  name                              = "snet-${var.project_name}-adf-${var.location}-${var.env}-001"
  resource_group_name               = azurerm_resource_group.network.name
  virtual_network_name              = azurerm_virtual_network.main.name
  address_prefixes                  = [var.adf_subnet_address_space]
  private_endpoint_network_policies = "Disabled"

}

resource "azurerm_subnet" "databricks_containers" {
  name                 = "snet-${var.project_name}-adbpublic-${var.location}-${var.env}-001"
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [var.adbpublic_subnet_address_space]

  delegation {
    name = "databricks"

    service_delegation {
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action",
      ]
      name = "Microsoft.Databricks/workspaces"
    }
  }
}

resource "azurerm_subnet" "databricks_host" {
  name                 = "snet-${var.project_name}-adbprivate-${var.location}-${var.env}-001"
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [var.adbprivate_subnet_address_space]

  private_endpoint_network_policies = "Enabled"

  delegation {
    name = "databricks"

    service_delegation {
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action",
      ]
      name = "Microsoft.Databricks/workspaces"
    }
  }
  service_endpoints = var.databricks_private_subnet_endpoints
}

resource "azurerm_subnet" "databricks_transit" {
  name                 = "snet-${var.project_name}-adbtransit-${var.location}-${var.env}-001"
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [var.adbtransit_subnet_address_space]
  ## private_endpoint_network_policies = "Disabled"
  private_endpoint_network_policies = "Enabled"
}

## @TODO: check this
resource "azurerm_subnet_network_security_group_association" "databricks_containers" {
  subnet_id                 = azurerm_subnet.databricks_containers.id
  network_security_group_id = azurerm_network_security_group.databricks_nsg.id
}

resource "azurerm_subnet_network_security_group_association" "databricks_host" {
  subnet_id                 = azurerm_subnet.databricks_host.id
  network_security_group_id = azurerm_network_security_group.databricks_nsg.id
}

resource "azurerm_network_security_group" "databricks_nsg" {
  name                = "snet-${var.project_name}-adbtransit-${var.location}-${var.env}-001"
  location            = var.location
  resource_group_name = azurerm_resource_group.network.name
}
