locals {
  prefix = "lab"
  location = "East US"
  storage_suffix = "storage813"
  tags = {
    Env = "lab"
  }
}
provider "azurerm" {
  version = "~>1"
  features { }
}
resource "azurerm_resource_group" "storage" {
    name     = "${local.prefix}-storage"
    location = local.location
    tags = local.tags
}
resource "azurerm_storage_account" "storage" {
  name                = "${local.prefix}${local.storage_suffix}"
  location = local.location
  resource_group_name = azurerm_resource_group.storage.name
  account_tier = "Standard"
  account_replication_type = "LRS"
  account_kind = "StorageV2"
  enable_https_traffic_only = "true"
}
