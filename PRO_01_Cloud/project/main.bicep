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
var webServerAllowedSSHIp = managementserverVM.outputs.nicPrivateIp

@description('Automated naming for the NSG')
param webServerNSGName string = '${webServerSubnetName}-NSG'

@description('Automated naming for the webserver virtual machine')
param webServerVmName string = 'webserver-${uniqueString(resourceGroup().id)}'

@description('The administrator login username for the Web server.')
param webServerAdminLogin string = 'webAdmin'

@description('SSH Key or password for the Web server. SSH key is recommended.')
@secure()
param webServerAdminLoginPassword string


// All managementserver params/var
@description('The name of the vnet where the managemetn server is deployed')
param managementServerVnetName string = 'management-prd-vnet'

@description('The address prefix for the management server vnet')
param managementServerVnetAddressPrefix string = '10.20.20.0/24'

@description('The address prefix for the management server subnet')
param managementServerSubnetAddressPrefix string = '10.20.20.0/25'

@description('The name of the subnet where the managemetn server is deployed')
param managementServerSubnetName string = 'managementServerSubnet'

@description('The name of the NSG for the management server')
param managementServerNSGName string = '${managementServerSubnetName}-NSG'

@description('The name of the management server with unique suffix')
param manamentServerVmName string = 'managementserver-${uniqueString(resourceGroup().id)}'

@description('The administrator login username for the Management server.')
param managementServerAdminLogin string = 'mngmntAdmin'

@description('SSH Key or password for the Management server. SSH key is recommended.')
@secure()
param managementServerAdminLoginPassword string

// Set up all the permissions for the management server within the keyvault
param managementServerKeysPermissions array = ['all']
param managementServerSecretPermissions array = ['all']
param managementServerCertificatesPermissions array = ['all']

// KV / Secrets params
@description('Specifies the name of the key vault.')
param keyVaultName string = 'kv-${uniqueString(resourceGroup().id)}'

// KeyVault (Working?)
module kv 'modules/kv.bicep' = {
  name: keyVaultName
  params: {
    location: location
  }
}

// // This is needed to use getSecret(), however I don't know how that works yet
// resource myKv 'Microsoft.KeyVault/vaults@2023-02-01' existing = {
//   name: keyVaultName
// }

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

// Webserver virtual network (WORKS, subnet, nsg included)
@description('The module to define th-e Webserver vnet, including subnet and NSG, see "modules/network.bicep" for more detailed information.')
module webserverVnet 'modules/network.bicep' = {
  name: webServerVnetName
  params: {
    location: location
    networkSecurityGroupName: webServerNSGName
    subnetAddressPrefix: webServerSubnetAddressPrefix
    subnetName: webServerSubnetName
    vnetAddressPrefix: webServerVnetAddressPrefix
    vnetNetworkName: webServerVnetName
    allowedSSHIp: webServerAllowedSSHIp
  }
}

// Webserver virtual network (WORKS, asg included | no backup, no key-pair)

@description('The module to define the Managementserver vnet, including subnet and NSG, see "modules/network.bicep" for more detailed information.')
module managementserverVnet 'modules/network.bicep' = {
  name: managementServerVnetName
  params: {
    location: location
    networkSecurityGroupName: managementServerNSGName
    subnetAddressPrefix: managementServerSubnetAddressPrefix
    subnetName: managementServerSubnetName
    vnetAddressPrefix: managementServerVnetAddressPrefix
    vnetNetworkName: managementServerVnetName
  }
}

// // Virtual Machine for the web server (WORKS, asg included | no backup, no key-pair)
// module webserverVM 'modules/virtualmachine.bicep' = {
//   name: webServerVmName
//   params: {
//     location: location
//     adminPasswordOrKey: webServerAdminLoginPassword
//     adminUsername: webServerAdminLogin
//     networkSecurityGroupId: webserverVnet.outputs.subnetNsgId
//     subnetId: webserverVnet.outputs.SubnetId
//     vmName: webServerVmName
//   }
// }

// // Virtual Machine for the management server (WORKS)
// module managementserverVM 'modules/virtualmachine.bicep' = {
//   name: manamentServerVmName
//   params: {
//     location: location
//     adminPasswordOrKey: managementServerAdminLoginPassword
//     adminUsername: managementServerAdminLogin
//     networkSecurityGroupId: managementserverVnet.outputs.subnetNsgId
//     subnetId: managementserverVnet.outputs.SubnetId
//     vmName: manamentServerVmName
//   }
// }

module webserverVM 'modules/virtualmachine.bicep' = {
  name: webServerVmName
  params: {
    adminPasswordOrKey:webServerAdminLoginPassword
    adminUsername: webServerAdminLogin
    kvName: kv.name
    location:  location
    networkSecurityGroupId: webserverVnet.outputs.subnetNsgId
    subnetId: webserverVnet.outputs.SubnetId
    vmName: webServerVmName 
  }
}

module managementserverVM 'modules/virtualmachine.bicep' = {
  name: manamentServerVmName
  params: {
    adminPasswordOrKey: managementServerAdminLoginPassword
    adminUsername: managementServerAdminLogin
    keysPermissions: managementServerKeysPermissions
    secretsPermissions: managementServerSecretPermissions
    certificatesPermissions: managementServerCertificatesPermissions
    kvName: kv.name
    location: location
    networkSecurityGroupId: managementserverVnet.outputs.subnetNsgId
    subnetId: managementserverVnet.outputs.SubnetId
    vmName: manamentServerVmName
  }
}

// Peering bothways web and management server (WORKS)
module vnetPeering 'modules/vnetpeering.bicep' = {
  name: 'vnetPeering'
  params: {
    vnet1Name: webserverVnet.name
    vnet2Name: managementserverVnet.name
  }
}

output sshManagementServer string = managementserverVM.outputs.sshCommand


