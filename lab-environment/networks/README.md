# Lab networks (Terraform files)

Setup basic lab networks and route tables that can be used by other examples.

You can specify what address space to use with the variable `vnet_address_space`.  The default is 10.50.200.0/22 and the current definition will divide that subnet into four /24 segments.  When supplied the default address space the following is created:

VNET (10.50.200.0/22)
- external_subnet (10.50.200.0/24)
- dmz_subnet (10.50.201.0/24)
- internal_subnet (10.50.203.0/24)

DMZ and Internal Route Tables
- `route_table_appliance_ip` setting is used to specify the last octect for a virtual appliance on the dmz and internal subnets, it defaults to 10.
- dmz and internal route tables and associations with local vnet traffic staying within vnet but all internet traffic routed to a virtual appliance on `route_table_appliance_ip` IP
- For example, the DMZ route table has an entry saying all internet traffic is routed to the virtual appliance on 10.50.201.10.

## Terraform Outputs
```
dmz_gw_address = 10.50.201.10
dmz_subnet_name = dmz-subnet
dmz_subnet_range = 10.50.201.0/24
external_subnet_address = 10.50.200.0/24
external_subnet_name = external-subnet
external_subnet_range = 10.50.200.0/24
internal_gw_address = 10.50.203.10
internal_subnet_address = 10.50.203.0/24
internal_subnet_name = internal-subnet
internal_subnet_range = 10.50.203.0/24
vnet_address_space = 10.50.200.0/22
```