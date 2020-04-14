# Check Point and Azure Labs using Terraform
Variety of lab scenarios using Terraform and Azure

## IMPORTANT: Azure Security Configuration

There are two parts of the lab configuration which require additional security setup:
1. Using Terraform to make changes including adding and removing objects in a subscription
    - In the labs below we use the [service principal with a client secret](https://www.terraform.io/docs/providers/azurerm/guides/service_principal_client_secret.html) configuration.  We recommend setting these values using the `ARM_SUBSCRIPTION_ID, ARM_TENANT_ID, ARM_CLIENT_ID, ARM_CLIENT_SECRET` environment variables, but you can also login via Azure CLI (az login) as an alternative.

1. Using Azure to store Terraform state information for usage by other modules and scripts
    - We use a SAS token to access the storage container for the below examples.  We recommend setting this value using the `ARM_SAS_TOKEN` environment variable.

## Installation

1. Install [Visual Studio Code](https://code.visualstudio.com/) ([download here](https://code.visualstudio.com/Download))
1. Install [Git SCM](https://git-scm.com/) ([download here](https://git-scm.com/downloads))
1. Clone github repo to a working directory on your local filesystem (must be run as an account with ability to create symlinks)

    `git -c core.symlinks=true clone https://github.com/chkp-wbelt/tf-labs.git`
1. Edit example.code-workspace
   1. Update the values for your Azure Security Configuration
   1. Save or rename file to your preference
1. Open new workspace file in Visual Studio Code
