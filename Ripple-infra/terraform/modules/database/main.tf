resource "azurerm_postgresql_flexible_server" "db" {
  name                = var.db_name
  resource_group_name = var.resource_group_name
  location            = var.location
  administrator_login = "pgadmin"
  administrator_password = "SuperSecurePassword123!"
  sku_name            = "B_Standard_B1ms"
  storage_mb          = 32768
  version             = "13"
}

module "private_endpoint" {
  source                         = "../private_endpoint"
  name                           = "${azurerm_postgresql_flexible_server.db.name}-pe"
  location                       = var.location
  resource_group_name            = var.resource_group_name
  subnet_id                      = var.private_endpoint_subnet_id
  private_service_connection_name = "postgresql-connection"
  resource_id                    = azurerm_postgresql_flexible_server.db.id
  subresource_names              = ["postgresqlServer"]
}

module "managed_identity" {
  source              = "../managed_identity"
  name                = "${var.db_name}-mi"
  location            = var.location
  resource_group_name = var.resource_group_name
}

module "rbac" {
  source = "../rbac"
  role_assignments = {
    # Assuming a role for database access, but PostgreSQL might not have built-in roles like this
    # This is placeholder; adjust as needed
    contributor = {
      scope                = azurerm_postgresql_flexible_server.db.id
      role_definition_name = "Contributor"
      principal_id         = module.managed_identity.principal_id
    }
  }
}
