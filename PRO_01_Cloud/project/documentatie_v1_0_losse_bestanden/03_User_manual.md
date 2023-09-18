# The Azure deployment

Before you deploy, please go through the following steps!

## Install Azure Powershell

[Link to installation guide](https://learn.microsoft.com/en-us/powershell/azure/install-azps-windows?view=azps-10.3.0&tabs=powershell&pivots=windows-psgallery)

01: Check if powershell 7.x.x or higher is installed
`$PSVersionTable.PSVersion`

02: Check if you have Az Powershell installed (if installed skip to step 6)
`Get-Module -Name AzureRM -ListAvailable`

03: Check execution policies
`Get-ExecutionPolicy -List`

04: Set execution policies (Requires Admin rights)
`Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`

05: Installation
`Install-Module -Name Az -Repository PSGallery -Force`

06: Check for updates
`Update-Module -Name Az -Force`

## Login to Azure and go to the folder where the project is based

We need to login to Azure

```powershell
Connect-AzAccount
```

Then set the file path to where the project is

```powershell
cd '<path/to/folder>'
```

## Change predeployment.bicep

- We need to set a prefix for the RG name
 `param rgNamePrefix string = 'Your Resource Group prefix'`

## Change main.bicepparam

- We need to set the two secrets in the param file:  
    param webServerAdminLoginPassword = getSecret('subscriptionId', 'resourceGroup Name', 'keyvaultName', 'secretname')
    param webServerAdminLoginPassword = getSecret('subscriptionId', 'resourceGroup Name', 'keyvaultName', 'secretname')

- We can get the resource group name and KeyVault name with:  
 `New-AzSubscriptionDeployment -whatif -templatefile .\predeployment.json -Location`

- We can get the subscription id with:
 `Get-AzSubscription -TenantId (Get-AzContext).Tenant`

- Set a secret name
 `You will get prompted to enter them when running the deployment script, this must be the same as you wrote in the param file`

## Change kv.bicep

- We need to set an Admin with all KeyVault rights
 `param objectId string = 'Your object ID'`

## Run the deployment file

```powershell
.\deployment_app.ps1
```
