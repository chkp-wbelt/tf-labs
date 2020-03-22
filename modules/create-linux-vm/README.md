# Create Ubuntu Linux VM in Azure (Terraform nodules)
Create a new Ubuntu Linux VM in Azure with support for variables

## Structure
```
└── create-linux-vm
    ├── main.tf
    ├── outputs.tf
    ├── README.md
    └── variables.tf
```
## Usage
This example would create two new VMs (web1 and db1)
```hcl
module "web1" {
    source = "../modules/create-linux-vm"
    vm_name_prefix = "web1"
    tags = {
        Env = "lab"
        ServerCategory = "web"
        ServerType = "apache"
    }
}
module "db1" {
    source = "../modules/create-linux-vm"
    vm_name_prefix = "db1"
    tags = {
        Env = "lab"
        ServerCategory = "db"
        ServerType = "mysql"
    }
}
```
## Variables
```hcl
- vm_name (string) The name for the new virtual machine (default = "lab1")
- vm_custom_data (string) Custom data passed to the vm (default = "")
- vm_ssh_key_data (string) SSH key data passed to the vm (default = "")
- vnet_name (string) vNet name used for the VM NIC interface (default = "lab-network")    
- vnet_resource_group (string) Resource group for the vNet used for the VM NIC interface (default = "lab-network")
- subnet_name (string) Subnet name used for the VM NIC interface (default = "internal-subnet")
- assign_public_ip (bool) Assign a public IP to instance? (default = false)
- tags (map/string) Tags to be added on the objects created
    default = {
        Env = "lab"
    }
```