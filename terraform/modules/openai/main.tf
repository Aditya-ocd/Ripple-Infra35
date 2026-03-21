resource "azurerm_cognitive_account" "openai" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = "OpenAI"
  sku_name            = "S0"
}

module "private_endpoint" {
  source                         = "../private_endpoint"
  name                           = "${azurerm_cognitive_account.openai.name}-pe"
  location                       = var.location
  resource_group_name            = var.resource_group_name
  subnet_id                      = var.private_endpoint_subnet_id
  private_service_connection_name = "openai-connection"
  resource_id                    = azurerm_cognitive_account.openai.id
  subresource_names              = ["account"]
}

module "managed_identity" {
  source              = "../managed_identity"
  name                = "${var.name}-mi"
  location            = var.location
  resource_group_name = var.resource_group_name
}

module "rbac" {
  source = "../rbac"
  role_assignments = {
    cognitive_services_user = {
      scope                = azurerm_cognitive_account.openai.id
      role_definition_name = "Cognitive Services User"
      principal_id         = module.managed_identity.principal_id
    }
  }
}
