@description('The region where all resources will be deployed to')
@allowed([
  'westeurope'
  'uksouth'
])
param location string = 'uksouth'

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

// All webserver params/var
param webServerVnetName string = 'app-prd-vnet'
param webServerVnetAddressPrefix string = '10.10.10.0/24'
param webServerSubnetName string = 'webServerSubnet'
param webServerSubnetAddressPrefix string = '10.10.10.0/25'
param webServerAllowedSSHIp string= managementServerSubnetAddressPrefix

@description('Automated naming for the NSG')
param webServerNSGName string = '${webServerSubnetName}-NSG'

@description('Automated naming for the webserver virtual machine')
param webServerVmName string = 'webserver-${uniqueString(resourceGroup().id)}'

@secure()
@description('The administrator login username for the Web server.')
param webServerAdminLogin string 

@secure()
@description('The administrator login password for the Web server.')
param webServerAdminLoginPassword string 


// All managementserver params/var
param managementServerVnetName string = 'management-prd-vnet'
param managementServerVnetAddressPrefix string = '10.20.20.0/24'
param managementServerSubnetAddressPrefix string = '10.20.20.0/25'
param managementServerSubnetName string = 'managementServerSubnet'
param managementServerNSGName string = '${managementServerSubnetName}-NSG'
param managementServerAllowedSSHIp string = '*'
param manamentServerVmName string = 'managementserver-${uniqueString(resourceGroup().id)}'

@secure()
@description('The administrator login username for the Management server.')
param managementServerAdminLogin string 

@secure()
@description('The administrator login password for the Management server.')
param managementServerAdminLoginPassword string 

// KV / Secrets params
// @description('Specifies the name of the key vault.')
// param keyVaultName string = 'kv-${uniqueString(resourceGroup().id)}'

// StorageAccount (WORKS)
@description('The storage account for the blob container for post deployment scripts')
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageAccountSkuName
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Cool'
    supportsHttpsTrafficOnly: true
  }
}

// Blob container for scripts (WORKS)
@description('The blob container for post deployment scripts, only deploys IF storageaccount is availible')
resource storageBlobScripts 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = {
  name: '${storageAccountName}/default/${containerNameScripts}'
  dependsOn: [
    storageAccount
  ]
}

// Webserver virtual network (WORKS)
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

// Webserver virtual network (WORKS)
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

// Peering web to management Vnets (WORKS)
module peeringWebserverToManagementServer 'modules/vnetpeering.bicep' = {
  name: 'peering-Webserver-to-ManagementServer'
  params: {
    vnet1Name: webserverVnet.name
    vnet2Name: managementserverVnet.name
  }
}

// Peering management to web Vnets (WORKS)
module peeringManagementServerToWebserver 'modules/vnetpeering.bicep' = {
  name: 'peering-ManagementServer-to-Webserver'
  params: {
    vnet1Name: managementserverVnet.name
    vnet2Name: webserverVnet.name
  }
}

// module kv 'modules/kv.bicep' = {
//   name: keyVaultName
//   params: {
//     location: location
//   }
// }

// Virtual Machine for the web server (WORKS)
module webserverVM 'modules/virtualmachine.bicep' = {
  name: webServerVmName
  params: {
    location: location
    adminPasswordOrKey: webServerAdminLoginPassword
    adminUsername: webServerAdminLogin
    networkSecurityGroupId: webserverVnet.outputs.subnetNsgId
    subnetId: webserverVnet.outputs.SubnetId
    vmName: webServerVmName
  }
}

// Virtual Machine for the management server (WORKS)
module managementserverVM 'modules/virtualmachine.bicep' = {
  name: manamentServerVmName
  params: {
    location: location
    adminPasswordOrKey: managementServerAdminLoginPassword
    adminUsername: managementServerAdminLogin
    networkSecurityGroupId: managementserverVnet.outputs.subnetNsgId
    subnetId: managementserverVnet.outputs.SubnetId
    vmName: manamentServerVmName
  }
}

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

output sshWebServer string = webserverVM.outputs.sshCommand
output sshManagementServer string = managementserverVM.outputs.sshCommand


