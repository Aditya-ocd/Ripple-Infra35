location = "eastus"
resource_group_names = {
  container_env       = "rg-cae-aios-dev-eastus"
  keyvault            = "rg-kv-aios-dev-eastus"
  openai              = "rg-openai-aios-dev-eastus"
  email_communication = "rg-ecs-aios-dev-eastus"
  communication       = "rg-comms-aios-dev-eastus"
  database            = "rg-psql-aios-dev-eastus"
  storage             = "rg-st-aios-dev-eastus"
}

container_apps_config = {
  env_name = "cae-aios-dev-eastus"
  apps = {
    login = "aca-aios-login-dev-eastus"
    ui    = "aca-aios-ui-dev-eastus"
    api   = "aca-aios-api-dev-eastus"
  }
}

keyvault_config = {
  kv_name = "kv-aios-dev-eastus"
}

openai_config = {
  name = "openai-aios-dev-eastus"
}

ecs_config = {
  services = {
    email = "ecs-aios-dev-eastus"
  }
}

communication_config = {
  services = {
    communication = "comms-aios-dev-eastus"
  }
}

database_config = {
  db_name = "psql-aios-dev-eastus"
}

storage_config = {
  storage_account_name = "staiosdveeastus"
}

vnet_config = {
  name                = "vnet-app-aios-dev-eastus"
  resource_group_name = "rg-cae-aios-dev-eastus"
}

subnet_configs = {
  login = {
    address_prefixes = ["10.0.1.0/24"]
  }
  ui = {
    address_prefixes = ["10.0.2.0/24"]
  }
  api = {
    address_prefixes = ["10.0.3.0/24"]
  }
}