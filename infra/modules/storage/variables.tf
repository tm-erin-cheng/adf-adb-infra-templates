variable "env" {
  type = string
}
variable "project_name" {
  type = string
}
variable "location" {
  type = string
}
variable "network_resource_group_name" {
  type = string
}
variable "storage_resource_group_name" {
  type = string
}
variable "virtual_network_id" {
  type = string
}
variable "storage_subnet_id" {
  type = string
}
variable "managed_identity_principal_id" {
  type = string
}
variable "tags" {
  type = map(string)
}