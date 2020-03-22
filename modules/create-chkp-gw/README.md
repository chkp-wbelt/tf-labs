# Create Check Point Gateway in Azure (Terraform module)
Create a new Check Point Gateway in Azure with support for variables

## Structure
```
└── create-chkp-gw
    ├── main.tf
    ├── outputs.tf
    ├── README.md
    └── variables.tf
```
## Usage
This example would create two new gateways, gw1 as R80.30 and gw2 as R80.40.

source is a relative path from the terraform file to the directory with the modules.

./ indicates the current directory
../ indicates the parent (up one) directory, multiple ../../ can be used to navigate the filesystem

```hcl
module "gw1" {
    source = "./modules/create-chkp-gw"
    gw_name = "gw1"
    offer = "check-point-cg-r8030"
    admin_password = "example-admin-pw!123"
    sic_password = "example-sic-pw!123"
    private_external_ip = "10.50.200.10"
    private_internal_ip = "10.50.203.10"
    tags = {
        Env = "lab"
        ServerCategory = "security"
        ServerType = "gateway"
    }
}
module "gw2" {
    source = "./modules/create-chkp-gw"
    gw_name = "gw2"
    offer = "check-point-cg-r8040"
    admin_password = "example-admin-pw!123"
    sic_password = "example-sic-pw!123"
    private_external_ip = "10.50.200.11"
    private_internal_ip = "10.50.203.11"
    tags = {
        Env = "lab"
        ServerCategory = "security"
        ServerType = "gateway"
    }
}
```
## Variables
```hcl
- gw_name (string) The name for the new gateway / virtual machine (default = "gwtest1")
- gw_instance_size (string) Azure VM instance size for gateways (default = "Standard_D2_v3")
- offer (string) Azure Marketplace offer string to use for gateway image (default = "check-point-cg-r8040")
- admin_password (string) Password for the admin user (default = "anythingSECURE")
- sic_password (string) Password for SIC to the gateway (default = "moreSECURITY")
- vnet_name (string) vNet name used for the VM NIC interface (default = "lab-network")    
- vnet_resource_group (string) Resource group for the vNet used for the VM NIC interface (default = "lab-network")
- private_external_ip (string) Private external IP address (default = "10.99.1.10"
- private_internal_ip (string) Private internal IP address (default = "10.99.10.10")
- tags (map/string) Tags to be added on the objects created
    default = {
        Env = "lab"
    }
```