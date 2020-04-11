variable "vnet_address_space" {
    type = string
    default = ""
    description = "Address space for the vnet"
}
variable "route_table_appliance_ip" {
    type = number
    default = 10
    description = "Last octet for the IP address used by the virtual appliance in the route table"
}
variable "tags" {
    type = map(string)
    description = "Tags to be added on the objects created"
    default = {
        Env = "lab"
    }
}