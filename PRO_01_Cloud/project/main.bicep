// Main bicep file, will load modules
// Default landing page Bicep resources, check references in left menu https://learn.microsoft.com/en-us/azure/templates/

  // param file? probably
  // https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/parameter-files?tabs=Bicep

  // param policies?
  // https://learn.microsoft.com/en-us/azure/governance/policy/assign-policy-bicep?tabs=azure-powershell

  // param location = resourceGroup.location

  // Tags
  // https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/tag-resources-bicep

// Locations allowed for deployment, low latency, low cost
@allowed([
  'westeurope'
  'uksouth'
])
param location string = 'westeurope'

// // Secure logins for management and web server, will be stored in keyvault
// @secure()
// @description('The administrator login username for the Management server.')
// param managementServerAdminLogin string

// @secure()
// @description('The administrator login password for the Management server.')
// param managementServerAdminLoginPassword string

// @secure()
// @description('The administrator login username for the Web server.')
// param webServerAdminLogin string

// @secure()
// @description('The administrator login password for the Web server.')
// param webServerAdminLoginPassword string

// Storage account and deployment script parameters
@description('The storage account name must be globally unique only letters lowercase')
  // take makes sure it doens't exceed the 24 char limit, toLower makes sure everything is lower cases as required.
param storageAccountName string = take(toLower('stgAc${uniqueString(resourceGroup().id)}'),24) 

@description('The name for the PostDeploymentScripts storage')
param storageBlobScriptsName string = 'PostDeploymentScripts'

@description('')
@allowed([
  'Standard_LRS'
  'Standard_GRS'
])
param storageAccountSkuName string = 'Standard_LRS'

resource strorageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageAccountSkuName
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Cool'
  }
}

// // Won't deploy, maybe needs to be launched as a container
// resource storageBlobScripts 'Microsoft.Storage/storageAccounts/blobServices@2023-01-01' = {
//   parent: strorageAccount
//   name: storageBlobScriptsName
// }




  
// module webServer 'modules/virtualMachine.bicep' = {
  // Define the resource in modules/virtualMachine.bicep
// }

// module managementServer 'modules/virtualMachine.bicep' = {
  // Define the resource in modules/virtualMachine.bicep
// }

// // Need to find out how these work in Bicep
// Module Peering?\
  // Define resource in network.bicep?
  // Connect Vnet 1 and 2

// Module vaults
  // Snapshot? Standard tier?

// Module KeyVault
  // Define in keyVault.bicep or main.bicep?
  // https://learn.microsoft.com/en-us/azure/templates/microsoft.keyvault/vaults?pivots=deployment-language-bicep
  // Store SSH key for webserver
  // Storage SSH key for managementserver

// Module RBAC (see alternatives?)
  // https://learn.microsoft.com/nl-nl/azure/azure-resource-manager/bicep/scenarios-rbac
  // Admin account
  // Extend in future?

