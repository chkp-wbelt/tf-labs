# Lab networks (Terraform files)

Setup basic lab networks and route tables that can be used by other examples.

## Usage
Please ensure you have created symlinks to `init.tf` for the below commands to work properly!  Refer to [mklinks section](https://github.com/chkp-wbelt/tf-labs#mklinks) for more details.

From the `lab-environment\networks` directory
1. `terraform init`
1. `terraform workspace list` -- to see a list of existing workspaces
    1. `terraform workspace new lab-network` -- the "lab-network" string is used in the [terraform_remote_state](https://www.terraform.io/docs/providers/terraform/d/remote_state.html) configuration section of `init.tf` please update this value if your use a different setting
    1. `terraform workspace select lab-network` -- if the workspace was already created previously
1. `terraform plan`
1. `terraform apply`

## Details

You can specify what address space to use with the variable `vnet_address_space`.  The default is 10.50.200.0/22 and the current definition will divide that subnet into four /24 segments.  When supplied the default address space the following is created:

### lab-network virtual network (10.50.200.0/22)
- external_subnet (10.50.200.0/24)
- dmz_subnet (10.50.201.0/24)
- internal_subnet (10.50.203.0/24)

### DMZ and Internal Route Tables
- `route_table_appliance_ip` setting is used to specify the last octet for a virtual appliance on the dmz and internal subnets, it defaults to 10.
- dmz and internal route tables and associations with local vnet traffic staying within vnet but all internet traffic routed to a virtual appliance on `route_table_appliance_ip` IP
- For example, the DMZ route table has an entry directing all internet traffic to the virtual appliance at 10.50.201.10

### Terraform Outputs (used with [terraform_remote_state](https://www.terraform.io/docs/providers/terraform/d/remote_state.html))
```
dmz_gw_address = 10.50.201.10
dmz_subnet_name = dmz-subnet
dmz_subnet_range = 10.50.201.0/24
external_subnet_name = external-subnet
external_subnet_range = 10.50.200.0/24
internal_gw_address = 10.50.203.10
internal_subnet_name = internal-subnet
internal_subnet_range = 10.50.203.0/24
storage_name = labstorage813
storage_rg = lab-storage
vnet_address_space = 10.50.200.0/22
```