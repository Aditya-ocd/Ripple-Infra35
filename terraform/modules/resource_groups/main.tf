resource "azurerm_resource_group" "rgs" {
  for_each = var.resource_group_names

  name     = each.value
  location = var.location
  tags     = var.tags
}
