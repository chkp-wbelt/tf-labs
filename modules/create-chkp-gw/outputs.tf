data "azurerm_public_ip" "ip" {
  name                = "${azurerm_resource_group.rg.name}-public-ip"
  resource_group_name = azurerm_virtual_machine.gw.resource_group_name
}
data "azurerm_network_interface" "nic" {
    name                = "${azurerm_resource_group.rg.name}-external-nic"
    resource_group_name = azurerm_virtual_machine.gw.resource_group_name
}
output "external_ip_address" {
  value = data.azurerm_network_interface.nic.ip_configuration.0.private_ip_address
  description = "Private EXTERNAL IP address for the new gw"
}
output "public_ip_address" {
  value = data.azurerm_public_ip.ip.ip_address
  description = "Public IP address for the new gw"
}