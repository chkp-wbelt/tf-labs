data "azurerm_storage_account" "storage" {
  name                = var.storage_name
  resource_group_name = var.storage_rg

}
resource "azurerm_storage_share" "share" {
  name                 = var.container_name
  storage_account_name = data.azurerm_storage_account.storage.name
  quota                = var.storage_size
}
resource "azurerm_resource_group" "rg" {
  name     = "lab-${var.container_name}"
  location = data.azurerm_storage_account.storage.location
}
resource "azurerm_container_group" "cg" {
  name                = var.container_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_address_type     = "public"
  dns_name_label      = "${var.container_name}-tpalab"
  os_type             = "Linux"

  container {
    name   = "n1"
    image  = "atmoz/sftp:alpine"
    cpu    = "1"
    memory = "1"

    ports {
      port     = 22
      protocol = "TCP"
    }
    environment_variables = {"SFTP_USERS" = "${var.sftp_username}:${var.sftp_password}:1001"}

    volume {
      name = "filedata"
      mount_path = "/home/${var.sftp_username}/upload"
      read_only = "false"
      storage_account_name = data.azurerm_storage_account.storage.name
      share_name = azurerm_storage_share.share.name
      storage_account_key = data.azurerm_storage_account.storage.primary_access_key
    }
  }
  tags = {
    Env            = "lab"
    ServerCategory = "utility"
    ServerType     = "sftp"
  }
}
