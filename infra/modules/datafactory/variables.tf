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
variable "adf_subnet_id" {
  type = string
}
variable "storage_account_id" {
  type = string
}
variable "storage_account_name" {
  type = string
}
variable "storage_account_primary_connection_string" {
  type = string
}
variable "tags" {
  type = map(string)
}