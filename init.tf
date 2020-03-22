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
data "terraform_remote_state" "lab_network" {
    backend = "azurerm"

    config = {
      storage_account_name = "labstorage813"
      container_name       = "lab-terraform"
      key                  = "lab-environment.tfstateenv:lab-network"
    }
}
variable "gw_instance_size" {
    type = string
    description = "Azure VM instance size for gateways"
    default = "Standard_D2_v3" #cheapest minimum gateway size (two nics)
}
variable "vm_instance_size" {
    type = string
    description = "Azure VM instance size for virtual machines"
    default = "Standard_B1ms" #cheapest instance size for basic vms
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
