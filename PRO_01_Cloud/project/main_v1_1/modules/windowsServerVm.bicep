@description('Location for all resources.')
param location string 

@description('Username for the Virtual Machine.')
param adminUsername string

// @description('Type of authentication to use on the Virtual Machine. SSH key is recommended.')
// @allowed([
//   'sshPublicKey'
//   'password'
// ])
// // param authenticationType string = 'sshPublicKey'

@description('SSH Key or password for the Virtual Machine. SSH key is recommended.')
@secure()
param adminPasswordOrKey string

param kvName string

// param userData string

@description('Specifies the permissions to keys in the vault. Valid values are: all, encrypt, decrypt, wrapKey, unwrapKey, sign, verify, get, list, create, update, import, delete, backup, restore, recover, and purge.')
param keysPermissions array 
@description('Specifies the permissions to secrets in the vault. Valid values are: all, get, list, set, delete, backup, restore, recover, and purge.')
param secretsPermissions array 
@description('Specifies the permissions to certificates in the vault. Valid values are: all, get, list ,update, create, import, delete, recover, backup, restore, purge')
param certificatesPermissions array 

@description('Set the availabilityZone for the VM')
@allowed([
  '1'
  '2'
])
param availabilityZone string 

@description('Unique DNS Name for the Public IP used to access the Virtual Machine.')
var dnsLabelPrefix = toLower('${vmName}-${uniqueString(resourceGroup().id)}')

@description('The Ubuntu version for the VM. This will pick a fully patched image of this given Ubuntu version.')
@allowed([
  '2019-Datacenter'
  '2022-Datacenter'
])
param windowsOSVersion string = '2022-Datacenter'

@description('The name of you Virtual Machine.')
param vmName string

@description('The size of the VM')
param vmSize string = 'Standard_B2s'

@description('The subnet ID you want to deploy to')
param subnetId string 

// @description('The NSG ID you want to deploy to')
// param networkSecurityGroupId string

param trustedIp string
param nsgName string

@description('Security Type of the Virtual Machine.')
@allowed([
  'Standard'
  'TrustedLaunch'
])
param securityType string = 'TrustedLaunch'

var imageReference = {
  '2019-Datacenter': {
    publisher: 'MicrosoftWindowsServer'
    offer: 'WindowsServer'
    sku: '2019-Datacenter-g2'
    version: 'latest'
  }
  '2022-Datacenter': {
    publisher: 'MicrosoftWindowsServer'
    offer: 'WindowsServer'
    sku: '2022-Datacenter-g2'
    version: 'latest'
  }
}

var publicIPAddressName = '${vmName}-PublicIP'
var networkInterfaceName = '${vmName}-Nic'
var osDiskType = 'Standard_LRS'

var securityProfileJson = {
  uefiSettings: {
    secureBootEnabled: true
    vTpmEnabled: true
  }
  securityType: securityType
}

resource kv 'Microsoft.KeyVault/vaults@2023-02-01' existing = {
  name: kvName
}

resource nsg 'Microsoft.Network/networkSecurityGroups@2023-04-01' existing = {
  name: nsgName
}

resource SshRule 'Microsoft.Network/networkSecurityGroups/securityRules@2023-04-01' = {
  parent: nsg
  name: 'AllowRDP'
  properties: {
    description: 'Allows for RPD connection from trusted IP addresses'
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '3389'
    sourceAddressPrefix: trustedIp
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 100
    direction: 'Inbound'
  }     
}

resource kvAccessPolicy 'Microsoft.KeyVault/vaults/accessPolicies@2023-02-01' = {
  name: 'add'
  parent: kv
  properties: {
    accessPolicies: [
      {
        applicationId: vm.identity.principalId
        objectId: vm.identity.principalId
        permissions: {
          certificates: certificatesPermissions
          keys: keysPermissions
          secrets: secretsPermissions
        }
        tenantId: vm.identity.tenantId
      }
    ]
  }
}

resource networkInterface 'Microsoft.Network/networkInterfaces@2023-04-01' = {
  name: networkInterfaceName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: subnetId
          }
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddress.id
            properties: {
              deleteOption: 'Delete'
            }
          }
        }
      }] 
      networkSecurityGroup: {
        id: nsg.id
      }
  }
}


resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2023-04-01' = {
  name: publicIPAddressName
  location: location
  zones: [availabilityZone]
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
    publicIPAddressVersion: 'IPv4'
    deleteOption: 'Delete'
    dnsSettings: {
      domainNameLabel: dnsLabelPrefix
    }
    idleTimeoutInMinutes: 4
  }
}

// resource newASG 'Microsoft.Network/applicationSecurityGroups@2023-04-01' = {
//   name: '${vmName}-ASG'
//   location: location
// }


resource vm 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: 'management'
  identity: {
    type:'SystemAssigned'
    }
  location: location
  zones: [availabilityZone]
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      adminPassword: adminPasswordOrKey
    }
    storageProfile: {
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: osDiskType
        }
        deleteOption: 'Delete'
      }
      imageReference: imageReference[windowsOSVersion]
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterface.id
          properties: {
            deleteOption: 'Delete'
          }
        }
      ]
    }
    // userData: userData
    securityProfile: ((securityType == 'TrustedLaunch') ? securityProfileJson : null)
  }
}

output vmId string = vm.id
output vmName string = vm.name
output nicPublicIp string = publicIPAddress.properties.ipAddress
output nicPrivateIp string = networkInterface.properties.ipConfigurations[0].properties.privateIPAddress
// output hostname string = publicIPAddress.properties.dnsSettings.fqdn
// output publicSsh string = 'ssh -i <path/to/key.pem> ${adminUsername}@${publicIPAddress.properties.dnsSettings.fqdn}'
// output privateSsh string = 'ssh ${adminUsername}@${networkInterface.properties.ipConfigurations[0].properties.privateIPAddress}'

