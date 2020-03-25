locals {
  prefix = "lab"
  location = "East US"
  storage_suffix = "storage813"
}
resource "azurerm_resource_group" "storage" {
    name     = "${local.prefix}-storage"
    location = local.location
    tags = var.tags
}
resource "azurerm_resource_group" "net" {
    name     = "${local.prefix}-network"
    location = azurerm_resource_group.storage.location
    tags = var.tags
}
resource "azurerm_virtual_network" "vnet" {
    name                = azurerm_resource_group.net.name
    address_space       = [ var.vnet_address_space ]
    location            = azurerm_resource_group.net.location
    resource_group_name = azurerm_resource_group.net.name
    tags = var.tags
}
resource "azurerm_subnet" "external_subnet"  {
    name           = "external-subnet"
    address_prefix = cidrsubnets(azurerm_virtual_network.vnet.address_space[0],2,2,2,2)[0]
    resource_group_name  = azurerm_resource_group.net.name
    virtual_network_name = azurerm_virtual_network.vnet.name
}
resource "azurerm_subnet" "dmz_subnet"  {
    name           = "dmz-subnet"
    address_prefix = cidrsubnets(azurerm_virtual_network.vnet.address_space[0],2,2,2,2)[1]
    resource_group_name  = azurerm_resource_group.net.name
    virtual_network_name = azurerm_virtual_network.vnet.name
}
resource "azurerm_subnet" "internal_subnet"   {
    name           = "internal-subnet"
    address_prefix = cidrsubnets(azurerm_virtual_network.vnet.address_space[0],2,2,2,2)[3]
    resource_group_name  = azurerm_resource_group.net.name
    virtual_network_name = azurerm_virtual_network.vnet.name
}
resource "azurerm_route_table" "dmz_routes" {
    name                = "${azurerm_resource_group.net.name}-dmz-routes"
    location            = azurerm_resource_group.net.location
    resource_group_name = azurerm_resource_group.net.name
    tags = var.tags

    route {
        name           = "internal"
        address_prefix = azurerm_virtual_network.vnet.address_space[0]
        next_hop_type  = "vnetlocal"
    }
    route {
        name           = "Internet"
        address_prefix = "0.0.0.0/0"
        next_hop_type  = "VirtualAppliance"
        next_hop_in_ip_address = cidrhost(azurerm_subnet.dmz_subnet.address_prefix,10)
    }
}
resource "azurerm_subnet_route_table_association" "dmz_rt_association" {
    subnet_id      = azurerm_subnet.dmz_subnet.id
    route_table_id = azurerm_route_table.dmz_routes.id
}
resource "azurerm_route_table" "internal_routes" {
    name                = "${azurerm_resource_group.net.name}-internal-routes"
    location            = azurerm_resource_group.net.location
    resource_group_name = azurerm_resource_group.net.name
    tags = var.tags

    route {
        name           = "internal"
        address_prefix = azurerm_virtual_network.vnet.address_space[0]
        next_hop_type  = "vnetlocal"
    }
    route {
        name           = "Internet"
        address_prefix = "0.0.0.0/0"
        next_hop_type  = "VirtualAppliance"
        next_hop_in_ip_address = cidrhost(azurerm_subnet.internal_subnet.address_prefix,10)
    }
}
resource "azurerm_subnet_route_table_association" "internal_rt_association" {
    subnet_id      = azurerm_subnet.internal_subnet.id
    route_table_id = azurerm_route_table.internal_routes.id
}
resource "azurerm_storage_account" "storage" {
  name                = local.storage_name
  location = azurerm_resource_group.storage.location
  resource_group_name = azurerm_resource_group.storage.name
  account_tier = "Standard"
  account_replication_type = "LRS"
  account_kind = "StorageV2"
  enable_https_traffic_only = "true"
}
