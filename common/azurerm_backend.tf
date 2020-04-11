locals {
  storage_account_name = "labstorage813" //TODO: Update for your storage account name
}
terraform {
  backend "azurerm" {
    storage_account_name = "labstorage813" //TODO: Update for your storage account name
    container_name       = "terraform"
    key                  = "state-"
  }
}
