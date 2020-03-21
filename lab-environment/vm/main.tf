module "web1" {
    source = "../../modules/create-linux-vm"
    vm_name_prefix = "web1"
    vm_ssh_key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAq9fqOSxm/68ECr2B2Q7qE64+o4pouYjSUY+DssJkU86fx0bNVHOgN+KlTIYCCzJ9fjqF1yy5G0BihmgDJolzMdCk121YvnjZfCPhzal0BK2+gz2no4CiSV4oHhoX3/kfZNGurmuKgt/Rq4eVU61bNBvukjo4RfycequcflZqTsqivEuGlpcJH4YgQ1wNZ9P622RX0w7U45FtQ2kk484XExT2fbzNGLg/YkZAMvcFIfeBKaEwQgOY4QwsYgr5WwtlVML0B9Fp1LPu67n4sCI5+8SlwNvXdZuVBjWlDJSTmZfIZaBfiGWAJr+4xVuLwwh5Q79Fzp0k0WsJheE335DGBw== wbelt@tpalab.com"
    vm_custom_data = <<-EOT
    #cloud-config
    runcmd:
      - "curl -s https://labstorage813.blob.core.windows.net/lab-bootstrap/bootstrap/apt-base.sh | bash"
      - "curl -s https://labstorage813.blob.core.windows.net/lab-bootstrap/bootstrap/apt-web-server.sh | bash"
    EOT
    assign_public_ip = true
    subnet_name = "external-subnet"
    tags = {
        Env = "lab"
        ServerCategory = "web"
        ServerType = "apache"
    }
}
module "web2" {
    source = "../../modules/create-linux-vm"
    vm_name_prefix = "web2"
    vm_ssh_key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAq9fqOSxm/68ECr2B2Q7qE64+o4pouYjSUY+DssJkU86fx0bNVHOgN+KlTIYCCzJ9fjqF1yy5G0BihmgDJolzMdCk121YvnjZfCPhzal0BK2+gz2no4CiSV4oHhoX3/kfZNGurmuKgt/Rq4eVU61bNBvukjo4RfycequcflZqTsqivEuGlpcJH4YgQ1wNZ9P622RX0w7U45FtQ2kk484XExT2fbzNGLg/YkZAMvcFIfeBKaEwQgOY4QwsYgr5WwtlVML0B9Fp1LPu67n4sCI5+8SlwNvXdZuVBjWlDJSTmZfIZaBfiGWAJr+4xVuLwwh5Q79Fzp0k0WsJheE335DGBw== wbelt@tpalab.com"
    vm_custom_data = <<-EOT
    #cloud-config
    runcmd:
      - "curl -s https://labstorage813.blob.core.windows.net/lab-bootstrap/bootstrap/apt-base.sh | bash"
      - "curl -s https://labstorage813.blob.core.windows.net/lab-bootstrap/bootstrap/apt-install-dvwa.sh | bash"
    EOT
    assign_public_ip = true
    subnet_name = "external-subnet"
    tags = {
        Env = "lab"
        ServerCategory = "web"
        ServerType = "apache"
    }
}
module "db1" {
    source = "../../modules/create-linux-vm"
    vm_name_prefix = "db1"
    vm_ssh_key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAq9fqOSxm/68ECr2B2Q7qE64+o4pouYjSUY+DssJkU86fx0bNVHOgN+KlTIYCCzJ9fjqF1yy5G0BihmgDJolzMdCk121YvnjZfCPhzal0BK2+gz2no4CiSV4oHhoX3/kfZNGurmuKgt/Rq4eVU61bNBvukjo4RfycequcflZqTsqivEuGlpcJH4YgQ1wNZ9P622RX0w7U45FtQ2kk484XExT2fbzNGLg/YkZAMvcFIfeBKaEwQgOY4QwsYgr5WwtlVML0B9Fp1LPu67n4sCI5+8SlwNvXdZuVBjWlDJSTmZfIZaBfiGWAJr+4xVuLwwh5Q79Fzp0k0WsJheE335DGBw== wbelt@tpalab.com"
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