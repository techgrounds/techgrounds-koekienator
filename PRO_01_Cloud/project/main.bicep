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
param storageAccountName string = take(toLower('scripts${uniqueString(resourceGroup().id)}'),24) 

@description('The name for the PostDeploymentScripts storage')
param containerNameScripts string = 'postdeploymentscripts'

// Vnet name params
param virtualNetworkName1 string = 'app-prd-vnet'
param virtualNetworkName2 string = 'management-prd-vnet'

// Subnet name params
param subnetName1 string = 'app-prd-subnet'
param subnetName2 string = 'management-prd-subnet'

// IP range params
param ipAdressRange1 string = '10.10.10.0/24'
param ipAdressRange2 string = '10.20.20.0/24'


@description('')
@allowed([
  'Standard_LRS'
  'Standard_GRS'
])
param storageAccountSkuName string = 'Standard_LRS'

// // StorageAccount Resources/Modules
// resource strorageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
//   name: storageAccountName
//   location: location
//   sku: {
//     name: storageAccountSkuName
//   }
//   kind: 'StorageV2'
//   properties: {
//     accessTier: 'Cool'
//   }
// }

// resource storageBlobScripts 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = {
//   name: '${storageAccountName}/default/${containerNameScripts}'
//   dependsOn: [
//     strorageAccount
//   ]
// }

// Network Resources/Modules

resource webserverVnet 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: virtualNetworkName1
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        ipAdressRange1
      ]
    }
    subnets: [
      {
        name: subnetName1
        properties: {
          addressPrefix: ipAdressRange1
        }
      }
    ]
  }

  resource subnet1 'subnets' existing = {
    name: subnetName1
  }
}

resource managementVnet 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: virtualNetworkName2
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        ipAdressRange2
      ]
    }
    subnets: [
      {
        name: subnetName2
        properties: {
          addressPrefix: ipAdressRange2
        }
      }
    ]
  }

  resource subnet2 'subnets' existing = {
    name: subnetName2
  }
}


  
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

