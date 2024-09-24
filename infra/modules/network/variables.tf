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
variable "data_resource_group_name" {
  type = string
}
variable "network_resource_group_name" {
  type = string
}
variable "storage_resource_group_name" {
  type = string
}
variable "vnet_address_space" {
  type = string
}
variable "storage_subnet_address_space" {
  type = string
}
variable "adf_subnet_address_space" {
  type = string
}
variable "adbpublic_subnet_address_space" {
  type = string
}
variable "adbprivate_subnet_address_space" {
  type = string
}
variable "adbtransit_subnet_address_space" {
  type = string
}
variable "databricks_private_subnet_endpoints" {
  default = []
}
variable "tags" {
  type = map(string)
}