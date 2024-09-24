module "network" {
  source = "../modules/network"

  env          = var.env
  project_name = var.project_name
  location     = var.location

  apps_resource_group_name            = var.apps_resource_group_name
  data_resource_group_name            = var.data_resource_group_name
  network_resource_group_name         = var.network_resource_group_name
  storage_resource_group_name         = var.storage_resource_group_name
  vnet_address_space                  = var.vnet_address_space
  storage_subnet_address_space        = var.storage_subnet_address_space
  adf_subnet_address_space            = var.adf_subnet_address_space
  adbpublic_subnet_address_space      = var.adbpublic_subnet_address_space
  adbprivate_subnet_address_space     = var.adbprivate_subnet_address_space
  adbtransit_subnet_address_space     = var.adbtransit_subnet_address_space
  databricks_private_subnet_endpoints = var.databricks_private_subnet_endpoints
  tags                                = local.tags
}
