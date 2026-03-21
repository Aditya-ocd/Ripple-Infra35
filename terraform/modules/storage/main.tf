resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

resource "azurerm_storage_account" "storage" {
  name                     = "${var.storage_account_name}${random_string.suffix.result}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

module "private_endpoint" {
  source                         = "../private_endpoint"
  name                           = "${azurerm_storage_account.storage.name}-pe"
  location                       = var.location
  resource_group_name            = var.resource_group_name
  subnet_id                      = var.private_endpoint_subnet_id
  private_service_connection_name = "storage-connection"
  resource_id                    = azurerm_storage_account.storage.id
  subresource_names              = ["blob"]
}

module "managed_identity" {
  source              = "../managed_identity"
  name                = "${var.storage_account_name}-mi"
  location            = var.location
  resource_group_name = var.resource_group_name
}

module "rbac" {
  source = "../rbac"
  role_assignments = {
    storage_contributor = {
      scope                = azurerm_storage_account.storage.id
      role_definition_name = "Storage Blob Data Contributor"
      principal_id         = module.managed_identity.principal_id
    }
  }
}
