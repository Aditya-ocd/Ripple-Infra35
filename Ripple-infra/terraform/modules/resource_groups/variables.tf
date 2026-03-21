variable "resource_group_names" {
  description = "Map of logical RG keys to RG names"
  type        = map(string)
}

variable "location" {
  description = "Location for the resource groups"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resource groups"
  type        = map(string)
  default     = {}
}
