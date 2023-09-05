// We can launch this Bicep file with the following command now.
// New-AzResourceGroupDeployment -TemplateFile main.bicep -environmentType nonprod

@description('Specifies the location for resources.')
param location string = 'westeurope'

@description('Specifies name for the following resources with unique IDs.')
param storageAccountName  string = 'koek${uniqueString(resourceGroup().id)}'
param appServiceAppName string = 'koek${uniqueString(resourceGroup().id)}'

@description('Set the possible envorinmnets')
@allowed([
  'nonprod'
  'prod'
])
param environmentType string

@description('Define the environment and set the SKU per environment')
var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'

@description('Define the Storage Account')
resource strorageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageAccountSkuName
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

@description('Define the App Service via the 02_appService.bicep module')
module appService '02_appService.bicep' = {
  name: 'appService'
  params: {
    location: location
    appServiceAppName: appServiceAppName
    environmentType: environmentType
  }
}

@description('Define output set in 02_appService.bicep to the appServiceAppHostName')
output appServiceAppHostName string = appService.outputs.appServiceAppHostName
