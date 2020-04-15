# Check Point and Azure Labs using Terraform
Variety of lab scenarios using Terraform and Azure

## IMPORTANT: Azure Security Configuration

There are two parts of the lab configuration which require additional security setup:
1. Using Terraform to make changes including adding and removing objects in a subscription
    - In the labs below we use the [service principal with a client secret](https://www.terraform.io/docs/providers/azurerm/guides/service_principal_client_secret.html) configuration.  We recommend setting these values using the `ARM_SUBSCRIPTION_ID, ARM_TENANT_ID, ARM_CLIENT_ID, ARM_CLIENT_SECRET` environment variables, but you can also login via Azure CLI (az login) as an alternative.

1. Using Azure to store Terraform state information for usage by other modules and scripts
    - We use a SAS token to access the storage container for the below examples.  We recommend setting this value using the `ARM_SAS_TOKEN` environment variable.

## Installation

### Tools
1. Install [Visual Studio Code](https://code.visualstudio.com/) ([download here](https://code.visualstudio.com/Download))
1. Install [Git SCM](https://git-scm.com/) ([download here](https://git-scm.com/downloads))

### Visual Studio Code Workspace
1. Edit example.code-workspace
   1. Update the values for your Azure Security Configuration
   1. Save or rename file to your preference

### Github
1. Clone github repo to a working directory on your local filesystem (must be run as an account with ability to create symlinks)
    ```
    git -c core.symlinks=true clone https://github.com/chkp-wbelt/tf-labs.git
    ```
1. Open new workspace file in Visual Studio Code

### Environment setup
Each configuration step requires running the terraform init and apply process, the plan step is optional and purely for informational purposes.  The directory from the project root is displayed in ()s

1. Run storage configuration (setup/storage)

   - Open setup/storage/main.tf for editing in VS code.
   - Update main.tf file with the `prefix`, `location` and `storage_suffix` values appropriate for your environment.  You may also optionally edit/update the `tags`.  The resulting storage account name will be prefix with storage_suffix added.  In the example, prefix=lab, storage_suffix=storage813 resulting in a storage account name of `labstorage813`
   - Terminal -> New Terminal in VS code with the main.tf file still open for editing.  This should open a new terminal in the setup/storage directory.

   ```
   terraform init
   terraform plan
   terraform apply
   ```
1. Run environment configuration (setup/environment)

   - Open setup/environment/main.tf for editing in VS code.
   - Update main.tf file with the `value` appropriate for your environment. This is the [terraform workspace](https://www.terraform.io/docs/state/workspaces.html) that will be used for the next step (network setup).  If this is a new environment, any value except "default" can be used, if this is an existing environment the name of the existing [terraform workspace](https://www.terraform.io/docs/state/workspaces.html) should be used.  
   - Terminal -> New Terminal in VS code with the main.tf file still open for editing.  This should open a new terminal in the setup/environment directory.

   ```
   terraform init
   terraform plan
   terraform apply
   ```
1. Run network configuration (setup/network)

   - Open setup/network/main.tf for editing in VS code.
   - Update main.tf file with the `prefix` and `location` appropriate for your environment. This should be the same values used in step 1 above in setup/storage. You may also optionally edit/update the `tags`.
   - Terminal -> New Terminal in VS code with the main.tf file still open for editing.  This should open a new terminal in the setup/network directory.
   - Use a `vnet_address_space` value for your environment.  The example of 10.50.200.0/22 is used below. This will create three /24 subnets from the range. 0 = external, 1 = dmz, 3 = internal.

   ```
   terraform init
   terraform plan -var="vnet_address_space=10.50.200.0/22" 
   terraform apply -var="vnet_address_space=10.50.200.0/22"
   ```

