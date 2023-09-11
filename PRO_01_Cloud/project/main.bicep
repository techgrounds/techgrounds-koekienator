// Deployment scope
targetScope = 'subscription'

// Location, default is uksouth
@description('The region where all resources will be deployed to')
@allowed([
  'westeurope'
  'uksouth'
])
param location string = 'uksouth'

// Storage account params
@description('The name prefix used to created the storageaccount')
var storageAccountName = take(toLower('stg${uniqueString(newRG.name)}'),24) 

@description('Set the SKU for the storage account: Standard_LRS or Standard_GRS')
@allowed([
  'Standard_LRS'
  'Standard_GRS'
])
param storageAccountSkuName string 

// Deployment Scripts Blob Container params
@description('The name for the PostDeploymentScripts storage')
param containerPostDeploymentScripts string 

// Webserver params
@description('The name prefix used for all webserver related resources')
param webServerNamePrefix string 

@description('The address for the webserver vnet')
param webServerVnetAddressPrefix string 

@description('The address for the webserver subnet')
param webServerSubnetAddressPrefix string 

@description('The administrator login username for the Web server.')
param webServerAdminLogin string 

@description('SSH Key or password for the Web server. SSH key is recommended.')
@secure()
param webServerAdminLoginPassword string

// Webserver variables
var webServerName = '${webServerNamePrefix}-${uniqueString(newRG.name)}'
var webServerVnetName  = '${webServerNamePrefix}-prd-vnet'
var webServerSubnetName = '${webServerNamePrefix}Subnet'
var webServerNSGName = '${webServerSubnetName}-NSG'
var webServerAllowedSSHIp = managementserverVM.outputs.nicPrivateIp

// Managementserver params
@description('The name prefix used for all management related resources')
param managementServerNamePrefix string 

@description('The address prefix for the management server vnet')
param managementServerVnetAddressPrefix string 

@description('The address prefix for the management server subnet')
param managementServerSubnetAddressPrefix string 

@description('SSH Key or password for the Management server. SSH key is recommended.')
@secure()
param managementServerAdminLoginPassword string = newGuid()

// Managementservers variables
var managementServerName = '${managementServerNamePrefix}-${uniqueString(newRG.name)}'
var managementServerVnetName  = '${managementServerNamePrefix}-prd-vnet'
var managementServerSubnetName = '${managementServerNamePrefix}ServerSubnet'
var managementServerNSGName = '${managementServerSubnetName}-NSG'


@description('The administrator login username for the Management server.')
param managementServerAdminLogin string = newGuid()

// Set up all the permissions for the webserver within the keyvault
@description('Specifies the permissions to keys in the vault. Valid values are: all, encrypt, decrypt, wrapKey, unwrapKey, sign, verify, get, list, create, update, import, delete, backup, restore, recover, and purge.')
param webServerKeysPermissions array

@description('Specifies the permissions to secrets in the vault. Valid values are: all, get, list, set, delete, backup, restore, recover, and purge.')
param webServerSecretPermissions array 

@description('Specifies the permissions to certificates in the vault. Valid values are: all, get, list ,update, create, import, delete, recover, backup, restore, purge')
param webServerCertificatesPermissions array 

// Set up all the permissions for the managementserver within the keyvault
@description('Specifies the permissions to keys in the vault. Valid values are: all, encrypt, decrypt, wrapKey, unwrapKey, sign, verify, get, list, create, update, import, delete, backup, restore, recover, and purge.')
param managementServerKeysPermissions array

@description('Specifies the permissions to secrets in the vault. Valid values are: all, get, list, set, delete, backup, restore, recover, and purge.')
param managementServerSecretPermissions array 

@description('Specifies the permissions to certificates in the vault. Valid values are: all, get, list ,update, create, import, delete, recover, backup, restore, purge')
param managementServerCertificatesPermissions array

// KV / Secrets params
@description('Specifies the name of the key vault.')
param keyVaulNamePrefix string
var keyVaultName = '${keyVaulNamePrefix}-${uniqueString(newRG.name)}'

// ResourceGroup params
param rgNamePrefix string
var resourceGroupName = '${rgNamePrefix}${uniqueString(subscription().subscriptionId)}'

module newRG 'modules/resourceGroup.bicep' = {
  name: resourceGroupName
  params: {
    resourceGroupLocation: location
    resourceGroupName: resourceGroupName
  }
}

// KeyVault (WORKING)
module kv 'modules/kv.bicep' = {
  name: keyVaultName
  scope: resourceGroup(newRG.name)
  params: {
    keyVaultName: keyVaultName
    location: location
  }
}

// storage account (WORKING)
module storageAccount 'modules/storage.bicep' = {
  name: storageAccountName
  scope: resourceGroup(newRG.name)
  params: {
    blobContainerName: containerPostDeploymentScripts
    location: location
    storageAccountName: storageAccountName
    storageAccountSkuName: storageAccountSkuName
  }
}

// Webserver virtual network (WORKS, subnet, nsg included)
@description('The module to define th-e Webserver vnet, including subnet and NSG, see "modules/network.bicep" for more detailed information.')
module webserverVnet 'modules/network.bicep' = {
  name: webServerVnetName
  scope: resourceGroup(newRG.name)
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
  scope: resourceGroup(newRG.name)
  params: {
    location: location
    networkSecurityGroupName: managementServerNSGName
    subnetAddressPrefix: managementServerSubnetAddressPrefix
    subnetName: managementServerSubnetName
    vnetAddressPrefix: managementServerVnetAddressPrefix
    vnetNetworkName: managementServerVnetName
  }
}


module webserverVM 'modules/virtualmachine.bicep' = {
  name: webServerName
  scope: resourceGroup(newRG.name)
  params: {
    virtualMachineLocation: location
    adminPasswordOrKey: webServerAdminLoginPassword
    adminUsername: webServerAdminLogin
    availabilityZone: '1'
    kvName: kv.name
    networkSecurityGroupId: webserverVnet.outputs.subnetNsgId
    subnetId: webserverVnet.outputs.SubnetId
    vmName: webServerName
    keysPermissions: webServerKeysPermissions
    secretsPermissions: webServerSecretPermissions
    certificatesPermissions: webServerCertificatesPermissions
  }
}

module managementserverVM 'modules/virtualmachine.bicep' = {
  name: managementServerName
  scope: resourceGroup(newRG.name)
  params: {
    virtualMachineLocation: location
    adminPasswordOrKey: managementServerAdminLoginPassword
    adminUsername: managementServerAdminLogin
    availabilityZone: '2'
    kvName: kv.name
    networkSecurityGroupId: managementserverVnet.outputs.subnetNsgId
    subnetId: managementserverVnet.outputs.SubnetId
    vmName: managementServerName
    keysPermissions: managementServerKeysPermissions
    secretsPermissions: managementServerSecretPermissions
    certificatesPermissions: managementServerCertificatesPermissions
  }
}

// Peering bothways web and management server (WORKS)
module vnetPeering 'modules/vnetpeering.bicep' = {
  name: 'vnetPeering'
  scope: resourceGroup(newRG.name)
  params: {
    vnet1Name: webserverVnet.name
    vnet2Name: managementserverVnet.name
  }
}

output sshManagementServer string = managementserverVM.outputs.sshCommand


