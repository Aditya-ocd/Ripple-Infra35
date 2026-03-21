variable "name" {
  description = "Name of the private endpoint"
  type        = string
}

variable "location" {
  description = "Location of the private endpoint"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the private endpoint"
  type        = string
}

variable "private_service_connection_name" {
  description = "Name of the private service connection"
  type        = string
}

variable "resource_id" {
  description = "Resource ID to connect to"
  type        = string
}

variable "subresource_names" {
  description = "Subresource names"
  type        = list(string)
}