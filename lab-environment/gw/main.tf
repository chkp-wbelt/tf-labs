module "gw1" {
    source = "../../modules/create-chkp-gw"
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
    source = "../../modules/create-chkp-gw"
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