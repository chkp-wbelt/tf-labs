variable "vm_name_prefix" {
    type = string
    default = "lab1"
    description = "The prefix used for the name of the virtual machine"
}
variable "vm_custom_data" {
    type = string
    description = "Custom data passed to the vm"
    default = ""
}
variable "vm_ssh_key_data" {
    type = string
    description = "Custom data passed to the vm"
    default = ""
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
variable "subnet_name" {
    type = string
    default = "internal-subnet"
    description = "Subnet name used for the VM NIC interface"
}
variable "assign_public_ip" {
    type = bool
    default = false
    description = "Set to true to assign a public IP to instance"
}
variable "tags" {
    type = map(string)
    description = "Tags to be added on the objects created"
    default = {
        Env = "lab"
    }
}
