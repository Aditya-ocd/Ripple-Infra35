resource "azurerm_key_vault" "kv" {
  name                = var.kv_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id
  sku_name            = "standard"
}

module "private_endpoint" {
  source                         = "../private_endpoint"
  name                           = "${azurerm_key_vault.kv.name}-pe"
  location                       = var.location
  resource_group_name            = var.resource_group_name
  subnet_id                      = var.private_endpoint_subnet_id
  private_service_connection_name = "keyvault-connection"
  resource_id                    = azurerm_key_vault.kv.id
  subresource_names              = ["vault"]
}

module "managed_identity" {
  source              = "../managed_identity"
  name                = "${var.kv_name}-mi"
  location            = var.location
  resource_group_name = var.resource_group_name
}

module "rbac" {
  source = "../rbac"
  role_assignments = {
    keyvault_secrets_user = {
      scope                = azurerm_key_vault.kv.id
      role_definition_name = "Key Vault Secrets User"
      principal_id         = module.managed_identity.principal_id
    }
  }
}
