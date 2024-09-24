output "apps_resource_group_name" {
  value = azurerm_resource_group.apps.name
}

output "data_resource_group_name" {
  value = azurerm_resource_group.data.name
}

output "network_resource_group_name" {
  value = azurerm_resource_group.network.name
}

output "storage_resource_group_name" {
  value = azurerm_resource_group.storage.name
}
output "virtual_network_id" {
  value = azurerm_virtual_network.main.id
}

output "storage_subnet_id" {
  value = azurerm_subnet.storage_private_endpoint.id
}
output "adf_subnet_id" {
  value = azurerm_subnet.adf_private_endpoint.id
}
output "adbpublic_subnet_name" {
  value = azurerm_subnet.databricks_containers.name
}

output "adbprivate_subnet_name" {
  value = azurerm_subnet.databricks_host.name
}
output "adbtransit_subnet_id" {
  value = azurerm_subnet.databricks_transit.id
}

## @TODO: check this
output "databricks_nsg_name" {
  value = azurerm_network_security_group.databricks_nsg.name
}

output "databricks_public_subnet_nsg_association_id" {
  value = azurerm_subnet_network_security_group_association.databricks_containers.id
}

output "databricks_private_subnet_nsg_association_id" {
  value = azurerm_subnet_network_security_group_association.databricks_host.id
}
