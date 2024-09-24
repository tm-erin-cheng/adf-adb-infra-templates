resource "random_string" "naming" {
  special = false
  upper   = false
  length  = 6
}

locals {
  // dltp - databricks labs terraform provider
  prefix   = join("-", ["tfdemo", "${random_string.naming.result}"])
  dbfsname = join("", ["dbfs", "${random_string.naming.result}"]) // dbfs name must not have special chars

  // tags that are propagated down to all resources
  tags = {
    Environment = "Testing"
    Epoch = random_string.naming.result
  }
}

resource "azurerm_databricks_access_connector" "main" {
  name                = "adb-${var.project_name}-${var.env}-001"
  resource_group_name = var.apps_resource_group_name
  location            = var.location

  identity {
    type = "SystemAssigned"
  }
}
