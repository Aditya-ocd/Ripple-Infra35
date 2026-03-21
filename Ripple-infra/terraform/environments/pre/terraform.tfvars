location = "eastus"
resource_group_names = {
  container_env       = "rg-cae-aios-pre-eastus"
  keyvault            = "rg-kv-aios-pre-eastus"
  openai              = "rg-openai-aios-pre-eastus"
  email_communication = "rg-ecs-aios-pre-eastus"
  communication       = "rg-comms-aios-pre-eastus"
  database            = "rg-psql-aios-pre-eastus"
  storage             = "rg-st-aios-pre-eastus"
}

container_apps_config = {
  env_name = "cae-aios-pre-eastus"
  apps = {
    login = "aca-aios-login-pre-eastus"
    ui    = "aca-aios-ui-pre-eastus"
    api   = "aca-aios-api-pre-eastus"
  }
}

keyvault_config = {
  kv_name = "kv-aios-pre-eastus"
}

openai_config = {
  name = "openai-aios-pre-eastus"
}

ecs_config = {
  services = {
    email = "ecs-aios-pre-eastus"
  }
}

communication_config = {
  services = {
    communication = "comms-aios-pre-eastus"
  }
}

database_config = {
  db_name = "psql-aios-pre-eastus"
}

storage_config = {
  storage_account_name = "staiospeastus"
}