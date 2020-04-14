data "terraform_remote_state" "network" {
    backend = "azurerm"

    config = {
      storage_account_name = local.storage_account_name
      container_name       = "terraform"
      key                  = "state-env:${data.terraform_remote_state.default.outputs.network_workspace}"
    }
}
