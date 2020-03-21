module "gw" {
    source = "../../modules/create-chkp-gw"
    gw_name = "azgw1"
    admin_password = "example-admin123"
    sic_password = "example-sic123"
    tags = {
        Env = "lab"
        ServerCategory = "security"
        ServerType = "gateway"
    }
}
module "web1" {
    source         = "../../modules/create-linux-vm"
    vm_name_prefix = "web1"
    vm_custom_data = <<-EOT
    #cloud-config
    runcmd:
      - "curl -s https://labstorage813.blob.core.windows.net/lab-bootstrap/bootstrap/apt-base.sh | bash"
      - "curl -s https://labstorage813.blob.core.windows.net/lab-bootstrap/bootstrap/apt-install-dvwa.sh | bash"
    EOT
    assign_public_ip = true
    subnet_name      = "external-subnet"
    tags = {
        Env            = "lab"
        ServerCategory = "web"
        ServerType     = "apache"
    }
}
module "db1" {
    source = "../../modules/create-linux-vm"
    vm_name_prefix = "db1"
    vm_custom_data = <<-EOT
    #cloud-config
      - "curl -s https://labstorage813.blob.core.windows.net/lab-bootstrap/bootstrap/apt-base.sh | bash"
      - "curl -s https://labstorage813.blob.core.windows.net/lab-bootstrap/bootstrap/apt-db-server.sh | bash"
    EOT
    assign_public_ip = false
    subnet_name = "internal-subnet"
    tags = {
        Env = "lab"
        ServerCategory = "db"
        ServerType = "mysql"
    }
}