module "web1" {
    source = "../../modules/create-linux-vm"
    vm_name = "web1"
    vm_ssh_key_data = var.ssh_key_data
    vm_custom_data = <<-EOT
    #cloud-config
    runcmd:
      - "curl -s https://labstorage813.blob.core.windows.net/lab-bootstrap/bootstrap/apt-base.sh | bash"
      - "curl -s https://labstorage813.blob.core.windows.net/lab-bootstrap/bootstrap/apt-web-server.sh | bash"
    EOT
    assign_public_ip = true
    subnet_name = data.terraform_remote_state.lab_network.outputs.external_subnet_name
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
      - "curl -s https://labstorage813.blob.core.windows.net/lab-bootstrap/bootstrap/apt-base.sh | bash"
      - "curl -s https://labstorage813.blob.core.windows.net/lab-bootstrap/bootstrap/apt-install-dvwa.sh | bash"
    EOT
    assign_public_ip = true
    subnet_name = data.terraform_remote_state.lab_network.outputs.external_subnet_name
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
      - "curl -s https://labstorage813.blob.core.windows.net/lab-bootstrap/bootstrap/apt-base.sh | bash"
      - "curl -s https://labstorage813.blob.core.windows.net/lab-bootstrap/bootstrap/apt-db-server.sh | bash"
    EOT
    assign_public_ip = false
    subnet_name = data.terraform_remote_state.lab_network.outputs.internal_subnet_name
    tags = {
        Env = "lab"
        ServerCategory = "db"
        ServerType = "mysql"
    }
}