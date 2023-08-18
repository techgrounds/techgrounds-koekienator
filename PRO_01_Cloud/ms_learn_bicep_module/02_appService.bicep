@description('Specifies the parameters used in the 02_main.bicep file')
param location string
param appServiceAppName string

@description('Set the possible envorinmnets')
@allowed([
  'nonprod'
  'prod'
])
param environmentType string

@description('Specifies name for the following resources with non-unique IDs.')
var appServicePlanName = 'koek-product-launch-plan-starter'

@description('Define the environment and set the SKU per environment')
var appServicePlanSkuName = (environmentType == 'prod') ? 'P2v3' : 'F1'

@description('Define the App Service plan')
resource appServicePlan 'Microsoft.Web/serverFarms@2022-03-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSkuName
  }
}

@description('Define the App Service app')
resource appServiceApp 'Microsoft.Web/sites@2022-03-01' = {
  name: appServiceAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}

@description('Define output for this module, can be called in the 02_main.bicep')
output appServiceAppHostName string = appServiceApp.properties.defaultHostName
