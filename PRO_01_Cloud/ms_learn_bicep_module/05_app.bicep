@description('The Azur region into which the resrouces should be deployed')
param location string

@description('The name of the App Service App')
param appServeiceAppName string

@description('The name of the App Service Plan')
param appServicePlanName string

@description('The name of the App Service plan SKU')
param appServicePlanSkuName string

resource appServicePlan 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: appServicePlanName
  location: location
  sku : {
    name: appServicePlanSkuName
  }
}

resource appServiceApp 'Microsoft.Web/sites@2022-09-01' = {
  name: appServeiceAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}

@description('The default host name of the App Service app')
output appServiceAppHostName string = appServiceApp.properties.defaultHostName
