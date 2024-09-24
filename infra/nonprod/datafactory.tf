module "datafactory" {
  source = "../modules/datafactory"

  env          = var.env
  project_name = var.project_name
  location     = var.location

  apps_resource_group_name                  = module.network.apps_resource_group_name
  network_resource_group_name               = module.network.network_resource_group_name
  virtual_network_id                        = module.network.virtual_network_id
  adf_subnet_id                             = module.network.adf_subnet_id
  storage_account_id                        = module.storage.storage_account_id
  storage_account_name                      = module.storage.storage_account_name
  storage_account_primary_connection_string = module.storage.storage_primary_connection_string
  tags                                      = local.tags
}
