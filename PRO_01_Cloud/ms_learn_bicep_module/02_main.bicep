// We can launch this Bicep file with the following command now.
// New-AzResourceGroupDeployment -TemplateFile main.bicep -environmentType nonprod

@description('Specifies the location for resources.')
param location string = 'westeurope'

@description('Specifies name for the following resources with unique IDs.')
param storageAccountName  string = 'koek${uniqueString(resourceGroup().id)}'
param appServiceAppName string = 'koek${uniqueString(resourceGroup().id)}'

@description('Automatically set the SKUs for each environment type.')
@allowed([
  'nonprod'
  'prod'
])
param environmentType string

@description('Specifies name for the following resources with non-unique IDs.')
var appServicePlanName = 'koek-product-launch-plan-starter'

@description('Define the environment and set the SLU per environment')
var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'
var appServicePlanSkuName = (environmentType == 'prod') ? 'P2v3' : 'F1'

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


@description('Define the App Service Plan')
resource appServicePlan 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSkuName
  }
}

@description('Define the App Service app')
resource appServiceApp 'Microsoft.Web/sites@2022-09-01' = {
  name: appServiceAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}


// nog deployen en screenshots maken voor md file
