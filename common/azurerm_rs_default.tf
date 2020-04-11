data "terraform_remote_state" "default" {
    backend = "azurerm"

    config = {
      storage_account_name = local.storage_account_name
      container_name       = "terraform"
      key                  = "state-"
    }
}
