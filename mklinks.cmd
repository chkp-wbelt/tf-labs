REM You must run with the ability to create symlinks, for example with administrator access, or developer mode access on Windows 10 enabled.

REM setup/storage links
mklink setup\storage\azurerm_provider.tf ..\..\common\azurerm_provider.tf

REM setup/environment links
mklink setup\environment\azurerm_provider.tf ..\..\common\azurerm_provider.tf
mklink setup\environment\azurerm_backend.tf ..\..\common\azurerm_backend.tf

REM setup/network links
mklink setup\network\azurerm_provider.tf ..\..\common\azurerm_provider.tf
mklink setup\network\azurerm_backend.tf ..\..\common\azurerm_backend.tf
mklink setup\network\azurerm_rs_default.tf ..\..\common\azurerm_rs_default.tf

REM lab-environment links
mklink lab-environment\gw\azurerm_provider.tf ..\..\common\azurerm_provider.tf
mklink lab-environment\gw\azurerm_backend.tf ..\..\common\azurerm_backend.tf
mklink lab-environment\gw\azurerm_rs_network.tf ..\..\common\azurerm_rs_network.tf

mklink lab-environment\sftp\azurerm_provider.tf ..\..\common\azurerm_provider.tf
mklink lab-environment\sftp\azurerm_backend.tf ..\..\common\azurerm_backend.tf

mklink lab-environment\vm\azurerm_provider.tf ..\..\common\azurerm_provider.tf
mklink lab-environment\vm\azurerm_backend.tf ..\..\common\azurerm_backend.tf
mklink lab-environment\vm\azurerm_rs_network.tf ..\..\common\azurerm_rs_network.tf
mklink lab-environment\vm\lab_vm_settings.tf ..\..\common\lab_vm_settings.tf
