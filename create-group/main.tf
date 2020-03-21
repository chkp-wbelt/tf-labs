resource "azurerm_resource_group" "rglab1" {
  name     = "Lab1"
  location = "East US"

  tags = {
    environment = "Lab"
    costcenter  = "IT"
  }
}
