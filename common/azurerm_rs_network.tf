locals {
  network_workspace_name = "lab-network" //TODO: Update for the workspace network was run in
}
data "terraform_remote_state" "network" {
    backend = "azurerm"

    config = {
      storage_account_name = local.storage_account_name
      container_name       = "terraform"
      key                  = "lab-environment.tfstateenv:${local.network_workspace_name}"
    }
}
