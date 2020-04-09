locals {
  prefix = "lab" //TODO: Update for your configuration
  location = "East US" //TODO: Update for your configuration
  storage_suffix = "storage813"  //TODO: Update for your configuration
  tags = {
    Env = "lab" //TODO: Update for your configuration
  }
}
provider "azurerm" {
  version = "~>1"
  features { }
}
resource "azurerm_resource_group" "storage" {
  name                      = "${local.prefix}-storage"
  location                  = local.location
  tags                      = local.tags
}
resource "azurerm_storage_account" "storage" {
  name                      = "${local.prefix}${local.storage_suffix}"
  location                  = azurerm_resource_group.storage.location
  resource_group_name       = azurerm_resource_group.storage.name
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  account_kind              = "StorageV2"
  enable_https_traffic_only = "true"
  tags                      = local.tags
}
data "azurerm_storage_account_sas" "apisas" {
  connection_string = azurerm_storage_account.storage.primary_connection_string
  https_only        = true

  resource_types {
    service   = false
    container = true
    object    = true
  }

  services {
    blob  = true
    queue = false
    table = false
    file  = false
  }

  start  = formatdate("YYYY-MM-DD",timeadd(timestamp(),"-24h"))
  expiry = formatdate("YYYY-MM-DD",timeadd(timestamp(),"8760h"))

  permissions {
    read    = true
    write   = true
    delete  = true
    list    = true
    add     = true
    create  = true
    update  = false
    process = false
  }
}
output "storage_name" {
  value = azurerm_storage_account.storage.name
  description = "Storage account name"
}
output "sas_url_query_string" {
  value = data.azurerm_storage_account_sas.apisas.sas
  description = "SAS URL Query string can be used in ARM_SAS_TOKEN environmental variable"
}
