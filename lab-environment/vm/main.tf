module "web1" {
    source = "../../modules/create-linux-vm"
    vm_name = "web1"
    vm_ssh_key_data = var.ssh_key_data
    vm_custom_data = <<-EOT
    #cloud-config
    runcmd:
      - "curl -s ${var.bootstrap_url}/apt-base.sh | bash"
      - "curl -s ${var.bootstrap_url}/apt-web-server.sh | bash"
    EOT
    vnet_name = data.terraform_remote_state.network.outputs.vnet_name
    vnet_resource_group_name = data.terraform_remote_state.network.outputs.vnet_resource_group_name
    assign_public_ip = true
    subnet_name = data.terraform_remote_state.network.outputs.external_subnet_name
    tags = {
        Env = "lab"
        ServerCategory = "web"
        ServerType = "apache"
    }
}
module "web2" {
    source = "../../modules/create-linux-vm"
    vm_name = "web2"
    vm_ssh_key_data = var.ssh_key_data
    vm_custom_data = <<-EOT
    #cloud-config
    runcmd:
      - "curl -s ${var.bootstrap_url}/apt-base.sh | bash"
      - "curl -s ${var.bootstrap_url}/apt-install-dvwa.sh | bash"
    EOT
    vnet_name = data.terraform_remote_state.network.outputs.vnet_name
    vnet_resource_group_name = data.terraform_remote_state.network.outputs.vnet_resource_group_name
    assign_public_ip = true
    subnet_name = data.terraform_remote_state.network.outputs.external_subnet_name
    tags = {
        Env = "lab"
        ServerCategory = "web"
        ServerType = "apache"
    }
}
module "db1" {
    source = "../../modules/create-linux-vm"
    vm_name = "db1"
    vm_ssh_key_data = var.ssh_key_data
    vm_custom_data = <<-EOT
    #cloud-config
      - "curl -s ${var.bootstrap_url}/apt-base.sh | bash"
      - "curl -s ${var.bootstrap_url}/apt-db-server.sh | bash"
    EOT
    vnet_name = data.terraform_remote_state.network.outputs.vnet_name
    vnet_resource_group_name = data.terraform_remote_state.network.outputs.vnet_resource_group_name
    assign_public_ip = false
    subnet_name = data.terraform_remote_state.network.outputs.internal_subnet_name
    tags = {
        Env = "lab"
        ServerCategory = "db"
        ServerType = "mysql"
    }
}
