module "storage" {
  source = "../modules/storage"

  env          = var.env
  project_name = var.project_name
  location     = var.location

  network_resource_group_name   = module.network.network_resource_group_name
  storage_resource_group_name   = module.network.storage_resource_group_name
  virtual_network_id            = module.network.virtual_network_id
  storage_subnet_id             = module.network.storage_subnet_id
  managed_identity_principal_id = module.databricks.managed_identity_principal_id
  tags                          = local.tags
}
