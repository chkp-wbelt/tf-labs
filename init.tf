provider "azurerm" {
  version = "~>2"
  features { }
}
locals {
  network_workspace_name = "lab-network" //TODO: Update for the workspace network was run in
}
terraform {
  backend "azurerm" {
    storage_account_name = "labstorage813" //TODO: Update for your storage account name
    container_name       = "lab-terraform"
    key                  = "lab-environment.tfstate"
  }
}
data "terraform_remote_state" "network" {
    backend = "azurerm"

    config = {
      storage_account_name = "labstorage813" //TODO: Update for your storage account name
      container_name       = "lab-terraform"
      key                  = "lab-environment.tfstateenv:${local.network_workspace_name}"
    }
}
variable "ssh_key_data" {
    type = string
    description = "ssh key data for authentication, can be populated via TF_VAR_ssh_key_data environmental variable"
    default = ""
}
variable "bootstrap_url" {
    type = string
    description = "bootstrap base URL value"
    default = "https://raw.githubusercontent.com/chkp-wbelt/tf-labs/master/bootstrap"
}
