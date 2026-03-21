output "names" {
  description = "Map of logical keys to resource group names"
  value       = { for k, rg in azurerm_resource_group.rgs : k => rg.name }
}

output "ids" {
  description = "Map of logical keys to resource group ids"
  value       = { for k, rg in azurerm_resource_group.rgs : k => rg.id }
}
