@description('Specifies the location for resources.')
param location string = 'westeurope'

resource strorageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: 'koekopslagaccount'
  location: location
  sku: {
    name: 'Standard_LRS'	
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

resource appServicePlan 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: 'koek-product-launch-plan-starter'
  location: location
  sku: {
    name: 'F1'
  }
}

resource appServiceApp 'Microsoft.Web/sites@2022-09-01' = {
  name: 'koek-product-launch-1'
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}


// nog deployen en screenshots maken voor md file
