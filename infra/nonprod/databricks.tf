module "databricks" {
  source = "../modules/databricks"

  env                                          = var.env
  project_name                                 = var.project_name
  location                                     = var.location
  apps_resource_group_name                     = module.network.apps_resource_group_name
  network_resource_group_name                  = module.network.network_resource_group_name
  virtual_network_id                           = module.network.virtual_network_id
  adbpublic_subnet_name                        = module.network.adbpublic_subnet_name
  adbprivate_subnet_name                       = module.network.adbprivate_subnet_name
  adbtransit_subnet_id                         = module.network.adbtransit_subnet_id
  databricks_nsg_name                          = module.network.databricks_nsg_name
  databricks_public_subnet_nsg_association_id  = module.network.databricks_public_subnet_nsg_association_id
  databricks_private_subnet_nsg_association_id = module.network.databricks_private_subnet_nsg_association_id
  tags                                         = local.tags
}


