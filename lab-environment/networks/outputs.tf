output "vnet_address_space" {
  value = var.vnet_address_space
  description = "Address space for the vnet"
}
output "external_subnet_name" {
  value = azurerm_subnet.external_subnet.name
  description = "External subnet name"
}
output "external_subnet_range" {
  value = azurerm_subnet.external_subnet.address_prefix
  description = "External subnet range"
}
output "internal_subnet_name" {
  value = azurerm_subnet.internal_subnet.name
  description = "Internal subnet name"
}
output "internal_subnet_range" {
  value = azurerm_subnet.internal_subnet.address_prefix
  description = "Internal subnet range"
}
output "internal_gw_address" {
  value = cidrhost(azurerm_subnet.internal_subnet.address_prefix,10)
  description = "Internal gateway address"
}
output "dmz_subnet_name" {
  value = azurerm_subnet.dmz_subnet.name
  description = "Internal subnet name"
}
output "dmz_subnet_range" {
  value = azurerm_subnet.dmz_subnet.address_prefix
  description = "Internal subnet range"
}
output "dmz_gw_address" {
  value = cidrhost(azurerm_subnet.dmz_subnet.address_prefix,10)
  description = "Internal gateway address"
}
