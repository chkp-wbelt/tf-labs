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

variable "ssh_key_data" {
    type = string
    description = "ssh key data for authentication, can be populated via TF_VAR_ssh_key_data environmental variable"
    default = ""
}
