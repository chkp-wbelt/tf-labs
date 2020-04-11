variable "ssh_key_data" {
    type = string
    description = "ssh key data for authentication, can be populated via TF_VAR_ssh_key_data environmental variable"
    default = ""
}
variable "bootstrap_url" {
    type = string
    description = "bootstrap base URL value"
    default = "https://raw.githubusercontent.com/chkp-wbelt/tf-labs/master/bootstrap"
}
