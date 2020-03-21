resource "azurerm_resource_group" "rg" {
    name     = "lab-network"
    location = "East US"

    tags = {
        environment = "lab"
    }
}
resource "azurerm_virtual_network" "vnet" {
    name                = azurerm_resource_group.rg.name
    address_space       = [ "10.50.200.0/22" ]
    location            = azurerm_resource_group.rg.location

    resource_group_name = azurerm_resource_group.rg.name
}
resource "azurerm_subnet" "external_subnet"  {
    name           = "external-subnet"
    address_prefix = "10.50.200.0/24"

    resource_group_name  = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
}
resource "azurerm_subnet" "internal_subnet"   {
    name           = "internal-subnet"
    address_prefix = "10.50.203.0/24"

    resource_group_name  = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
}
resource "azurerm_subnet" "dmz_subnet"  {
    name           = "dmz-subnet"
    address_prefix = "10.50.201.0/24"

    resource_group_name  = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
}
resource "azurerm_route_table" "dmz_routes" {
    name                = "${azurerm_resource_group.rg.name}-dmz-routes"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    route {
        name           = "internal"
        address_prefix = "10.50.200.0/22"
        next_hop_type  = "vnetlocal"
    }
    route {
        name           = "Internet"
        address_prefix = "0.0.0.0/0"
        next_hop_type  = "VirtualAppliance"
        next_hop_in_ip_address = "10.50.201.10"
    }
}
resource "azurerm_subnet_route_table_association" "dmz_rt_ssociation" {
    subnet_id      = azurerm_subnet.dmz_subnet.id
    route_table_id = azurerm_route_table.dmz_routes.id
}
resource "azurerm_route_table" "internal_routes" {
    name                = "${azurerm_resource_group.rg.name}-internal-routes"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    route {
        name           = "internal"
        address_prefix = "10.50.200.0/22"
        next_hop_type  = "vnetlocal"
    }
    route {
        name           = "Internet"
        address_prefix = "0.0.0.0/0"
        next_hop_type  = "VirtualAppliance"
        next_hop_in_ip_address = "10.50.203.10"
    }
}
resource "azurerm_subnet_route_table_association" "internal_rt_ssociation" {
    subnet_id      = azurerm_subnet.internal_subnet.id
    route_table_id = azurerm_route_table.internal_routes.id
}
