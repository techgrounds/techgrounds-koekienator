param location string = 'uksouth'
param rgNamePrefix string = 'testOmgeving'

var rgName = '${rgNamePrefix}${uniqueString(subscription().id)}'
var kvName = 'kv-${uniqueString(newRG.name)}'

targetScope = 'subscription'

module newRG 'modules/resourceGroup.bicep' = {
  name: rgName
  params: {
    resourceGroupLocation: location
    resourceGroupName: rgName
  }
}

module kv 'modules/kv.bicep' = {
  name: kvName
  scope: resourceGroup(newRG.name)
  params: {
    location: location
    keyVaultName: kvName
    createMode: 'recover'
  }
}

output getResourceGroupName string = newRG.outputs.resourceGroupName
output getKeyVaultName string = kv.outputs.keyVaultName
