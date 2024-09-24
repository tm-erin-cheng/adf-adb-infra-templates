output "storage_account_id" {
  value = azurerm_storage_account.main.id
}
output "storage_account_name" {
  value = azurerm_storage_account.main.name
}
output "storage_primary_connection_string" {
  value = azurerm_storage_account.main.primary_connection_string
}