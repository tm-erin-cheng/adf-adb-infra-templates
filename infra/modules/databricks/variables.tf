variable "env" {
  type = string
}
variable "project_name" {
  type = string
}
variable "location" {
  type = string
}
variable "apps_resource_group_name" {
  type = string
}
variable "network_resource_group_name" {
  type = string
}
variable "virtual_network_id" {
  type = string
}
variable "adbpublic_subnet_name" {
  type = string
}
variable "adbprivate_subnet_name" {
  type = string
}
variable "adbtransit_subnet_id" {
  type = string
}
variable "databricks_nsg_name" {
  type = string
}

variable "databricks_private_subnet_endpoints" {
  default = []
}
variable "databricks_public_subnet_nsg_association_id" {
  type = string
}

variable "databricks_private_subnet_nsg_association_id" {
  type = string
}
variable "tags" {
  type = map(string)
}