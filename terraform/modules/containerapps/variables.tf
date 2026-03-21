variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "environment_id" { type = string }
variable "apps" { type = map(string) }
variable "managed_identity_id" { type = string }
