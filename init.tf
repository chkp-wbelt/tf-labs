provider "azurerm" {
    version = "~> 1.44.0"
}

terraform {
  backend "azurerm" {
    storage_account_name = "labstorage813"
    container_name       = "lab-terraform"
    key                  = "lab-environment.tfstate"
  }
}