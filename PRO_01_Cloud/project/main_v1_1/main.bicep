// Location, default is uksouth
@description('The region where all resources will be deployed to')
@allowed([
  'westeurope'
  'uksouth'
])
param location string = 'uksouth'

// Storage account params
@description('The name prefix used to created the storageaccount')
var storageAccountName = take(toLower('stg${uniqueString(resourceGroup().id)}'),24) 

@description('Set the SKU for the storage account: Standard_LRS or Standard_GRS')
@allowed([
  'Standard_LRS'
  'Standard_GRS'
])
param storageAccountSkuName string 

// Deployment Scripts Blob Container params
@description('The name for the PostDeploymentScripts storage')
param blobContainerName string 

// Webserver params
param webServerNamePrefix string 
param webserverVnetName string 
param webserverVnetAddressPrefix string 
param subnetVmssAdressPrefix string 
param subnetAppGwAdressPrefix string 
// param webSslCertificateName string 
param webServerAdminLogin string 
@secure()
param webServerKey string

// Webserver variables
var webServerName = webServerNamePrefix
var webserverVmssName = '${webServerName}Vmss'
var webserverSubnetVmssName = '${webserverVmssName}Subnet'
var webserverAppGatewayName = '${webServerName}AppGateWay'
var webserverSubnetAppGwName = '${webserverAppGatewayName}Subnet'
var webserverBackendPoolName = '${webserverVmssName}BackendPool'
var webserverTrustedIp = managementserverVM.outputs.nicPrivateIp
var webUserData = loadFileAsBase64('customData/installApacheUbuntu.sh')

// Managementserver params
@description('Windows computer name cannot be more than 15 characters long, be entirely numeric, or special characters.')
@minLength(3)
@maxLength(15)
param managementServerName string
param managementServerNamePrefix string 
param managementerverVnetName string 
param managementserverVnetAddressPrefix string 
param managementserverTrustedIp string
param subnetManagementAdressPrefix string 
@secure()
param managementServerAdminLoginPassword string = newGuid()

// Managementservers variables
var managementSubnetName = '${managementServerNamePrefix}Subnet'
// var managementUserData = loadFileAsBase64('customData/installAzWindows.ps1')

@description('The administrator login username for the Management server.')
@secure()
param managementServerAdminLogin string

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

// KV var
@description('Specifies the name of the key vault.')
var kvName = 'kv-${uniqueString(resourceGroup().name)}'

module kv 'modules/kv.bicep' = {
  name: 'keyVault'
  params: {
    location: location
    keyVaultName: kvName
    createMode:  'default'
  }
}

// storage account (WORKING)
module storageAccount 'modules/storage.bicep' = {
  name: 'storage'
  params: {
    location: location

    // Storage Params
    storageAccountName: storageAccountName
    storageAccountSkuName: storageAccountSkuName

    // Blob container params
    blobContainerName: blobContainerName
  }
}

module webserverVnet 'modules/networkLoop.bicep' = {
  name: 'webAppVnet'
  params: {
    location: location
    // Vnet
    vnetNetworkName: webserverVnetName
    vnetAddressPrefix: webserverVnetAddressPrefix
    // Subnets
    numberOfSubnets: 2
    subnetAddressPrefix: [subnetVmssAdressPrefix, subnetAppGwAdressPrefix]
    subnetName: [webserverSubnetVmssName, webserverSubnetAppGwName]
  }
}

module managementserverVnet 'modules/networkLoop.bicep' = {
  name: 'managementVnet'
  params: {
    location: location

    // Vnet
    vnetNetworkName: managementerverVnetName
    vnetAddressPrefix: managementserverVnetAddressPrefix

    // Subnets
    numberOfSubnets: 1
    subnetAddressPrefix: [subnetManagementAdressPrefix]
    subnetName: [managementSubnetName]
  }
}

module webserverAppGateway 'modules/appGatewayV2.bicep' = {
  dependsOn: [
    webserverVnet
  ]
  name: 'appGateway'
  params: {
    location: location

    // appGateway params
    applicationGatewayName: webserverAppGatewayName
    myBackendPool: webserverBackendPoolName

    // Network params
    subnetId: webserverVnet.outputs.subnet[1].id
    nsgName: webserverVnet.outputs.nsg[1].name
  }
}

module webserverVmss 'modules/VmScaleSetv2.bicep' = {
  dependsOn: [
    webserverVnet
    webserverAppGateway
  ]
  name: 'webServer'
  params: {
    location: location

    // Vmss Params
    vmssName: webserverVmssName
    adminKey: webServerKey
    adminUsername: webServerAdminLogin  
    userData: webUserData

    // KeyVault Params
    kvName: kv.outputs.keyVaultName
    keysPermissions: webServerKeysPermissions
    secretsPermissions: webServerSecretPermissions
    certificatesPermissions: webServerCertificatesPermissions

    // Network Params
    subnetId: webserverVnet.outputs.subnet[0].id
    nsgName: webserverVnet.outputs.nsg[0].name
    trustedIpAddress: webserverTrustedIp
    appGatwayIp: webserverAppGateway.outputs.appGatwayIp
    backendpoolId: webserverAppGateway.outputs.backendpoolId
  }
}

module managementserverVM 'modules/windowsServerVm.bicep' = {
  dependsOn: [
    managementserverVnet
  ]
  name: 'managementServer'
  params: {
    location: location

    // Management Server params
    vmName: managementServerName
    adminPasswordOrKey: managementServerAdminLoginPassword
    adminUsername: managementServerAdminLogin
    availabilityZone: '2'
    // userData: managementUserData

    // KeyVault Params
    kvName: kv.outputs.keyVaultName
    keysPermissions: managementServerKeysPermissions
    secretsPermissions: managementServerSecretPermissions
    certificatesPermissions: managementServerCertificatesPermissions

    // Network Params
    subnetId: managementserverVnet.outputs.subnet[0].id
    nsgName: managementserverVnet.outputs.nsg[0].name
    trustedIp: managementserverTrustedIp
  }
}

// Peering bothways web and management server (WORKS)
module vnetPeering 'modules/vnetpeering.bicep' = {
  dependsOn: [
    webserverVnet
    managementserverVnet
  ]
  name: 'vnetPeering'
  params: {
    vnet1Name: webserverVnet.outputs.vnetName
    vnet2Name: managementserverVnet.outputs.vnetName
  }
}

