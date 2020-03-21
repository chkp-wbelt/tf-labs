# Project and Scenario directories

All of the directories here are example directories to represent projects:
- gw -- Check Point gateway example
- vm -- Linux web/db test servers example
- vm2 -- Linux web/db test servers example

Any directory (such as the above) is just a location to hold Terraform files for a particular project, environment, test, etc, however you choose to categorize your scenarios and configurations.  For convenience it is recommended to symlink back to the main `init.tf` if you wish to have some shared configurations.
