# Check Point and Terraform Labs using Azure
Variety of lab scenarios using Terraform and Azure

## IMPORTANT: Azure Security Configuration

- It is recommended to use environmental variables for your Azure related secrets, keys, IDs, etc.  Depending on how you have configured the security and delegration within Azure you will use a combination of the following values (but likely not all).

```
ARM_SUBSCRIPTION_ID, ARM_TENANT_ID, ARM_CLIENT_ID, ARM_SAS_TOKEN, ARM_CLIENT_SECRET
```
## Installation

1. Install [Git SCM](https://git-scm.com/) ([download here](https://git-scm.com/downloads))
1. Install [Visual Studio Code](https://code.visualstudio.com/) ([download here](https://code.visualstudio.com/Download))
1. Clone github repo to a working directory on your local filesystem

    `git clone https://github.com/chkp-wbelt/tf-labs.git`
1. Edit example.code-workspace
   1. Update the values for your Azure Security Configuration
   1. Save or rename file to your preference
1. Open new workspace file in Visual Studio Code
1. Edit [init.tf](#init-file) for your preferences!
1. Extend [init.tf](#init-file) using symlinks with [mklinks scripts](#mklinks) or manually using [ln](https://kb.iu.edu/d/abbe) with linix/mac) or [mklink](https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/mklink)  with windows.

## init-file

`init.tf` file is use to store environment wide configuration settings

You should use symlinks to create shared init files for your directories/projects where there is a configuration overlap.

For example to enable Azure resource manager in `init.tf` you would add the following:
```
provider "azurerm" {
    version = "~> 1.44.0"
}
```
To use an Azure blob for sharing and managing terraform state you can use the [azurerm backend provider](https://www.terraform.io/docs/backends/types/azurerm.html) with the following:
```
terraform {
  backend "azurerm" {
    storage_account_name = "YOUR-VALUE-HERE"
    container_name       = "lab-terraform"
    key                  = "lab-environment.tfstate"
  }
}
```
## mklinks

- `mklinks.cmd`-- Windows CMD file for creating symlinks for the example directories
- `mklinks.sh` -- Future enhancement, contributions welcome!

### Directories
- root -- [init.tf](#init-file), [mklinks](#mklinks), `README.md`
- modules -- all terraform modules
- (other directories) -- any other directory is just a location to hold Terraform files for a particular project, environment, test, etc, however you choose to categorize your scenarios and configurations.  For convenience it is recommended to symlink back to the main [init.tf](#init-file) if you wish to have some shared configurations.

```
├── create-group
│   └── main.tf
├── create-lab-networks
│   └── main.tf
├── lab-environment
│   ├── gw
│   │   ├── main.tf
│   │   └── outputs.tf
│   ├── vm
│   │   ├── main.tf
│   │   └── outputs.tf
│   └── vm2
│       ├── main.tf
│       └── outputs.tf
├── modules
│   ├── create-chkp-gw
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── create-linux-vm
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
├── example.code-workspace
├── init.tf
└── mklinks.cmd
```