resource "azurerm_marketplace_agreement" "checkpoint" {
  publisher = "checkpoint"
  offer     = var.offer
  plan      = "sg-byol"
}
data "azurerm_virtual_network" "vnet" {
    name                = var.vnet_name
    resource_group_name = var.vnet_resource_group_name
}
resource "azurerm_resource_group" "rg" {
    name     = var.gw_name
    location = data.azurerm_virtual_network.vnet.location
    tags     = var.tags
}
data "azurerm_subnet" "external_subnet"   {
    name                    = "external-subnet"
    resource_group_name     = data.azurerm_virtual_network.vnet.resource_group_name
    virtual_network_name    = data.azurerm_virtual_network.vnet.name
}
data "azurerm_subnet" "internal_subnet"   {
    name                    = "internal-subnet"
    resource_group_name     = data.azurerm_virtual_network.vnet.resource_group_name
    virtual_network_name    = data.azurerm_virtual_network.vnet.name
}
resource "azurerm_public_ip" "public_ip" {
    name                         = "${azurerm_resource_group.rg.name}-public-ip"
    location                     = azurerm_resource_group.rg.location
    resource_group_name          = azurerm_resource_group.rg.name
    domain_name_label            = "${azurerm_resource_group.rg.name}-tpalab"
    allocation_method            = "Dynamic"
    tags                         = var.tags
}
resource "azurerm_network_interface" "gw_external" {
    name                = "${azurerm_resource_group.rg.name}-external-nic"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    enable_ip_forwarding = "true"
    tags                         = var.tags
	ip_configuration {
        name                          = "external-ip-config"
        subnet_id                     = data.azurerm_subnet.external_subnet.id
        private_ip_address_allocation = "Static"
		private_ip_address = var.private_external_ip
        primary = true
		public_ip_address_id = azurerm_public_ip.public_ip.id
    }
}
resource "azurerm_network_interface" "gw_internal" {
    name                = "${azurerm_resource_group.rg.name}-internal-nic"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    enable_ip_forwarding = "true"
    tags                         = var.tags
	ip_configuration {
        name                          = "internal-ip-config"
        subnet_id                     = data.azurerm_subnet.internal_subnet.id
        private_ip_address_allocation = "Static"
		private_ip_address = var.private_internal_ip
    }
}
resource "azurerm_virtual_machine" "gw" {
    name                  = azurerm_resource_group.rg.name
    location              = azurerm_resource_group.rg.location
    resource_group_name   = azurerm_resource_group.rg.name
    network_interface_ids = [azurerm_network_interface.gw_external.id,azurerm_network_interface.gw_internal.id]
    primary_network_interface_id = azurerm_network_interface.gw_external.id
    tags                         = var.tags
    vm_size               = var.gw_instance_size
    
    depends_on = [azurerm_marketplace_agreement.checkpoint]

    storage_os_disk {
        name              = "${azurerm_resource_group.rg.name}-disk"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Standard_LRS"
    }
    storage_image_reference {
        publisher = azurerm_marketplace_agreement.checkpoint.publisher
        offer     = azurerm_marketplace_agreement.checkpoint.offer
        sku       = azurerm_marketplace_agreement.checkpoint.plan
        version   = "latest"
    }
    plan {
        name = azurerm_marketplace_agreement.checkpoint.plan
        publisher = azurerm_marketplace_agreement.checkpoint.publisher
        product = azurerm_marketplace_agreement.checkpoint.offer
        }
    os_profile {
        computer_name  = azurerm_resource_group.rg.name
        admin_username = "notused" #admin will still be the username
        admin_password = var.admin_password
        custom_data = "#!/bin/bash\n/bin/blink_config --config-string 'hostname=${azurerm_resource_group.rg.name}&ftw_sic_key=${var.sic_password}&install_security_gw=true&install_ppak=true&gateway_daip=false&gateway_cluster_member=false&install_security_managment=false&download_info=true&upload_info=true'\nshutdown -r now\n"
    }
    os_profile_linux_config {
        disable_password_authentication = false
    }
}