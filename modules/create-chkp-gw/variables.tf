variable "gw_name" {
    type = string
    default = "gwtest1"
    description = "The name for the new gateway / virtual machine"
}
variable "offer" {
    type = string
    default = "check-point-cg-r8040"
    description = "Azure Marketplace offer string to use for gateway image"
}
variable "admin_password" {
    type = string
    default = "anythingSECURE"
    description = "Password for the admin user"
}
variable "sic_password" {
    type = string
    default = "moreSECURITY"
    description = "Password for SIC to the gateway"
}
variable "vnet_name" {
    type = string
    default = "lab-network"
    description = "vNet name used for the VM NIC interface"
}
variable "vnet_resource_group" {
    type = string
    default = "lab-network"
    description = "Resource group for the vNet used for the VM NIC interface"
}
variable "private_external_ip" {
    type = string
    default = "10.99.1.10"
    description = "Private external IP address"
}
variable "private_internal_ip" {
    type = string
    default = "10.99.10.10"
    description = "Private internal IP address"
}
variable "tags" {
    type = map(string)
    description = "Tags to be added on the objects created"
    default = {
        environment = "lab"
    }
}