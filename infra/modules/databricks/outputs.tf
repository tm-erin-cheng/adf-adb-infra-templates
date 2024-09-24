output "managed_identity_principal_id" {
  value = azurerm_databricks_access_connector.main.identity[0].principal_id
}
