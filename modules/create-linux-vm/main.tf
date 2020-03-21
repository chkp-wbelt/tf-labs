
data "azurerm_virtual_network" "vnet" {
    name                = var.vnet_name
    resource_group_name = var.vnet_resource_group
}

data "azurerm_subnet" "subnet"   {
    name                    = var.subnet_name
    resource_group_name     = data.azurerm_virtual_network.vnet.resource_group_name
    virtual_network_name    = data.azurerm_virtual_network.vnet.name
}

resource "azurerm_resource_group" "rg" {
    name     = var.vm_name_prefix
    location = data.azurerm_virtual_network.vnet.location
    tags     = var.tags
}

resource "azurerm_public_ip" "public_ip" {
    count                        = var.assign_public_ip ? 1 : 0
    name                         = "${azurerm_resource_group.rg.name}-public-ip"
    location                     = azurerm_resource_group.rg.location
    resource_group_name          = azurerm_resource_group.rg.name
    domain_name_label            = "${azurerm_resource_group.rg.name}-tpalab"
    allocation_method            = "Dynamic"
    tags                         = var.tags
}

resource "azurerm_network_interface" "nic" {
    name                        = "${azurerm_resource_group.rg.name}-nic"
    location                    = azurerm_resource_group.rg.location
    resource_group_name         = azurerm_resource_group.rg.name
    tags                        = var.tags

    ip_configuration {
        name                          = "${azurerm_resource_group.rg.name}-nic-cfg"
        subnet_id                     = data.azurerm_subnet.subnet.id
        private_ip_address_allocation = "Dynamic"
        primary = true   
		public_ip_address_id = var.assign_public_ip ? azurerm_public_ip.public_ip[0].id : null
    }
}

resource "azurerm_virtual_machine" "vm" {
    name                  = azurerm_resource_group.rg.name
    location              = azurerm_resource_group.rg.location
    resource_group_name   = azurerm_resource_group.rg.name
    network_interface_ids = [azurerm_network_interface.nic.id]  
    vm_size               = "Standard_B1ms"
    tags                  = var.tags

    storage_os_disk {
        name              = "${azurerm_resource_group.rg.name}-disk"
        caching           = "ReadWrite"
        create_option     = "FromImage"
    }

    storage_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }

    os_profile {
        computer_name  = azurerm_resource_group.rg.name
        admin_username = "azureuser"
        custom_data = var.vm_custom_data
    }

    os_profile_linux_config {
        disable_password_authentication = true
        ssh_keys {
            path     = "/home/azureuser/.ssh/authorized_keys"
            key_data = var.vm_ssh_key_data
        }
    }
}