module "sftp" {
    source = "../../modules/create-sftp-server"
    container_name = "sftp1"
    sftp_username = "example-user"
    sftp_password = "example-password"
    storage_size = 50
    storage_name = data.terraform_remote_state.network.outputs.storage_name
    storage_rg = data.terraform_remote_state.network.outputs.storage_rg
    tags = {
        Env = "lab"
        ServerCategory = "utility"
        ServerType = "sftp"
    }
}