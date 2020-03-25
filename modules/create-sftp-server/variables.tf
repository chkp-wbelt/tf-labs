variable "container_name" {
    type = string
    default = "container1"
    description = "Name of the container"
}
variable "sftp_username" {
    type = string
    default = "default"
    description = "Name of the container"
}
variable "sftp_password" {
    type = string
    default = "secret"
    description = "Name of the container"
}
variable "storage_size" {
    type = number
    default = 50
    description = "Storage size in GB"
}
variable "storage_name" {
    type = string
    default = ""
    description = "Storage account name"
}
variable "storage_rg" {
    type = string
    default = ""
    description = "Storage account resource group"
}
variable "tags" {
    type = map(string)
    description = "Tags to be added on the objects created"
    default = {
        Env = "lab"
    }
}
