# Azure deployment

Before you deploy, please go through the following steps!

## Login to Azure and go to the folder where the project is based

We need to login to Azure

```powershell
Connect-AzAccount
```

Then set the file path to where the project is

```powershell
cd '<path/to/folder>'
```

## Change main.bicepparam

- We need to set the two secrets in the param file:  
    param webServerAdminLoginPassword = getSecret('subscriptionId', 'resourceGroup Name', 'keyvaultName', 'secretname')
    param webServerAdminLoginPassword = getSecret('subscriptionId', 'resourceGroup Name', 'keyvaultName', 'secretname')

- We can get the resource group name and keyvault name with:  
 `New-AzSubscriptionDeployment -whatif -templatefile .\predeployment.json -Location`

- We can get the subscription id with:
 `Get-AzSubscription -TenantId (Get-AzContext).Tenant`

- Think of a secret name, they must be different
 `You will get prompted to enter them when running the deployment script, might be handy to write them down in notepad or a similar program to copy/past them when prompted`

## Build the param file (with VsCode)

Right click on 'main.bicepparam' then select 'build parameters file'
The file should be converted to 'main.parameters.json'

## Run the deployment file

```powershell
.\deployment_app.ps1
```
