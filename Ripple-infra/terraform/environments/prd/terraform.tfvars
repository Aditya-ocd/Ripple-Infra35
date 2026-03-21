location = "eastus"
resource_group_names = {
  container_env       = "rg-cae-aios-prd-eastus"
  keyvault            = "rg-kv-aios-prd-eastus"
  openai              = "rg-openai-aios-prd-eastus"
  email_communication = "rg-ecs-aios-prd-eastus"
  communication       = "rg-comms-aios-prd-eastus"
  database            = "rg-psql-aios-prd-eastus"
  storage             = "rg-st-aios-prd-eastus"
}

container_apps_config = {
  env_name = "cae-aios-prd-eastus"
  apps = {
    login = "aca-aios-login-prd-eastus"
    ui    = "aca-aios-ui-prd-eastus"
    api   = "aca-aios-api-prd-eastus"
  }
}

keyvault_config = {
  kv_name = "kv-aios-prd-eastus"
}

openai_config = {
  name = "openai-aios-prd-eastus"
}

ecs_config = {
  services = {
    email = "ecs-aios-prd-eastus"
  }
}

communication_config = {
  services = {
    communication = "comms-aios-prd-eastus"
  }
}

database_config = {
  db_name = "psql-aios-prd-eastus"
}

storage_config = {
  storage_account_name = "staiospdeastus"
}