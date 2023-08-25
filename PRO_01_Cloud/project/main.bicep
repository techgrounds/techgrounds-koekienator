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

// Storage account params
@description('The storage account name must be globally unique only letters lowercase and max 24 char long')
param storageAccountName string = take(toLower('scripts${uniqueString(resourceGroup().id)}'),24) 

@description('')
@allowed([
  'Standard_LRS'
  'Standard_GRS'
])
param storageAccountSkuName string = 'Standard_LRS'

// Deployment Scripts Blob Container params
@description('The name for the PostDeploymentScripts storage')
param containerNameScripts string = 'postdeploymentscripts'

// All webserver params\
param webServerVnetName string = 'app-prd-vnet'
param webServerVnetAddressPrefix string = '10.10.10.0/24'
param webServerSubnetName string = 'webServerSubnet'
param webServerSubnetAddressPrefix string = '10.10.10.0/25'
param webServerNSGName string = '${webServerSubnetName}-NSG'
param webServerAllowedSSHIp string = managementServerSubnetAddressPrefix

// All managementserver params
param managementServerVnetName string = 'management-prd-vnet'
param managementServerVnetAddressPrefix string = '10.20.20.0/24'
param managementServerSubnetName string = 'managementServerSubnet'
param managementServerSubnetAddressPrefix string = '10.20.20.0/25'
param managementServerNSGName string = '${managementServerSubnetName}-NSG'
param managementServerAllowedSSHIp string = '*'

// StorageAccount (WORKS)
@description('The storage account for the blob container for post deployment scripts')
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

// Blob container for scripts (WORKS)
@description('The blob container for post deployment scripts, only deploys IF storageaccount is availible')
resource storageBlobScripts 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = {
  name: '${storageAccountName}/default/${containerNameScripts}'
  dependsOn: [
    strorageAccount
  ]
}

// Webserver virtual network
@description('The module to define the Webserver vnet, including subnet and NSG, see "modules/network.bicep" for more detailed information.')
module webserverVnet 'modules/network.bicep' = {
  name: webServerVnetName
  params: {
    location: location
    networkSecurityGroupName: webServerNSGName
    allowedSSHIp: webServerAllowedSSHIp
    subnetAddressPrefix: webServerSubnetAddressPrefix
    subnetName: webServerSubnetName
    vnetAddressPrefix: webServerVnetAddressPrefix
    vnetNetworkName: webServerVnetName
  }
}

// Webserver virtual network
@description('The module to define the Managementserver vnet, including subnet and NSG, see "modules/network.bicep" for more detailed information.')
module managementserverVnet 'modules/network.bicep' = {
  name: managementServerVnetName
  params: {
    location: location
    networkSecurityGroupName: managementServerNSGName
    allowedSSHIp: managementServerAllowedSSHIp
    subnetAddressPrefix: managementServerSubnetAddressPrefix
    subnetName: managementServerSubnetName
    vnetAddressPrefix: managementServerVnetAddressPrefix
    vnetNetworkName: managementServerVnetName
  }
}

// // Peering both Vnets
// @description('The peering connection from webserver to managementserver')
// resource web2management 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2023-04-01'{
// }

// @description('The peering connection from managementserver to webserver')
// resource management2web 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2023-04-01'{
  
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

