resource "azurerm_databricks_workspace" "main" {
  name                                  = "adb-${var.project_name}-${var.env}-001"
  resource_group_name                   = var.apps_resource_group_name
  location                              = var.location
  sku                                   = "premium"
  tags                                  = local.tags
  public_network_access_enabled         = true
  network_security_group_rules_required = "NoAzureDatabricksRules"
  customer_managed_key_enabled          = true
  custom_parameters {
    no_public_ip                                         = true
    virtual_network_id                                   = var.virtual_network_id
    public_subnet_name                                   = var.adbpublic_subnet_name
    private_subnet_name                                  = var.adbprivate_subnet_name
    public_subnet_network_security_group_association_id  = var.databricks_public_subnet_nsg_association_id
    private_subnet_network_security_group_association_id = var.databricks_private_subnet_nsg_association_id
    storage_account_name                                 = local.dbfsname
  }

  depends_on = [
    var.databricks_public_subnet_nsg_association_id,
    var.databricks_private_subnet_nsg_association_id
  ]
}
