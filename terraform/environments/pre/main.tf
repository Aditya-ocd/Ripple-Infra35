data "azurerm_client_config" "current" {}

module "resource_groups" {
  source               = "../../modules/resource_groups"
  resource_group_names = var.resource_group_names
  location             = var.location
}

data "azurerm_virtual_network" "existing" {
  name                = var.vnet_config.name
  resource_group_name = var.vnet_config.resource_group_name
}

resource "azurerm_subnet" "container_apps" {
  for_each = var.subnet_configs

  name                 = "subnet-${each.key}-cae"
  resource_group_name  = var.vnet_config.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.existing.name
  address_prefixes     = each.value.address_prefixes

  delegation {
    name = "Microsoft.App.environments"

    service_delegation {
      name    = "Microsoft.App/environments"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

resource "azurerm_subnet" "private_endpoints" {
  for_each = var.private_endpoint_subnet_configs

  name                 = "subnet-${each.key}-pe"
  resource_group_name  = var.vnet_config.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.existing.name
  address_prefixes     = each.value.address_prefixes
}

resource "azurerm_container_app_environment" "env" {
  name                     = var.container_apps_config.env_name
  location                 = var.location
  resource_group_name      = module.resource_groups.names["container_env"]
  infrastructure_subnet_id = azurerm_subnet.container_apps["login"].id
}

module "containerapps_mi" {
  source              = "../../modules/managed_identity"
  name                = "containerapps-mi"
  location            = var.location
  resource_group_name = module.resource_groups.names["container_env"]
}

module "containerapps" {
  source              = "../../modules/containerapps"
  resource_group_name = module.resource_groups.names["container_env"]
  location            = var.location
  environment_id      = azurerm_container_app_environment.env.id
  apps                = var.container_apps_config.apps
  managed_identity_id = module.containerapps_mi.id
}

module "keyvault" {
  source                     = "../../modules/keyvault"
  resource_group_name        = module.resource_groups.names["keyvault"]
  location                   = var.location
  kv_name                    = var.keyvault_config.kv_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  private_endpoint_subnet_id = azurerm_subnet.private_endpoints["keyvault"].id
}

module "openai" {
  source                     = "../../modules/openai"
  resource_group_name        = module.resource_groups.names["openai"]
  location                   = var.location
  name                       = var.openai_config.name
  private_endpoint_subnet_id = azurerm_subnet.private_endpoints["openai"].id
}

module "ecs" {
  source              = "../../modules/ecs"
  resource_group_name = module.resource_groups.names["email_communication"]
  location            = var.location
  services            = var.ecs_config.services
}

module "communication" {
  source              = "../../modules/communication"
  resource_group_name = module.resource_groups.names["communication"]
  location            = var.location
  services            = var.communication_config.services
}

module "database" {
  source                     = "../../modules/database"
  resource_group_name        = module.resource_groups.names["database"]
  location                   = var.location
  db_name                    = var.database_config.db_name
  private_endpoint_subnet_id = azurerm_subnet.private_endpoints["database"].id
}

module "storage" {
  source               = "../../modules/storage"
  resource_group_name  = module.resource_groups.names["storage"]
  location             = var.location
  storage_account_name = var.storage_config.storage_account_name
  private_endpoint_subnet_id = azurerm_subnet.private_endpoints["storage"].id
}
