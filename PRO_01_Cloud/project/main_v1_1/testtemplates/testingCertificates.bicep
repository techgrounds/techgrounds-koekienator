@description('Location for all resources.')
param location string = 'uksouth'

@description('Username for the Virtual Machine.')
param adminUsername string = 'koekAdmin'

@description('Type of authentication to use on the Virtual Machine. SSH key is recommended.')
@allowed([
  'sshPublicKey'
  'password'
])
param authenticationType string = 'password'

param testlog string = '@1989Koek!'

param userData string = loadFileAsBase64('../customData/installApacheUbuntu.sh')

@description('Set the availabilityZone for the VM')
@allowed([
  '1'
  '2'
])
param availabilityZone string = '1'

@description('Unique DNS Name for the Public IP used to access the Virtual Machine.')
var dnsLabelPrefix = toLower('${vmName}-${uniqueString(resourceGroup().id)}')

@description('The Ubuntu version for the VM. This will pick a fully patched image of this given Ubuntu version.')
@allowed([
  'Ubuntu-2004'
  'Ubuntu-2204'
])
param ubuntuOSVersion string = 'Ubuntu-2204'

@description('The name of you Virtual Machine.')
param vmName string = 'testCertificates'

@description('The size of the VM')
param vmSize string = 'Standard_B1ls'

@description('Security Type of the Virtual Machine.')
@allowed([
  'Standard'
  'TrustedLaunch'
])
param securityType string = 'Standard'

var imageReference = {
  'Ubuntu-2204': {
    publisher: 'Canonical'
    offer: '0001-com-ubuntu-server-jammy'
    sku: '22_04-lts-gen2'
    version: 'latest'
  }
}

var publicIPAddressName = '${vmName}-PublicIP'
var networkInterfaceName = '${vmName}-Nic'
var osDiskType = 'Standard_LRS'

var linuxConfiguration = {
  disablePasswordAuthentication: true
  ssh: {
    publicKeys: [
      {
        path: '/home/${adminUsername}/.ssh/authorized_keys'
        keyData: testlog
      }
    ]
  }
}

var securityProfileJson = {
  uefiSettings: {
    secureBootEnabled: true
    vTpmEnabled: true
  }
  securityType: securityType
}

resource vnet 'Microsoft.Network/virtualNetworks@2023-04-01' = {
  name: 'vnet1'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/24'
      ]
    }
  }
}

resource subnet1 'Microsoft.Network/virtualNetworks/subnets@2023-04-01' = {
  name: 'subnet1'
  parent: vnet
  properties: {
    addressPrefix: '10.0.0.0/24'
    networkSecurityGroup: {
      id: nsg.id
    }
  }
}

resource nsg 'Microsoft.Network/networkSecurityGroups@2023-04-01' = {
  name: 'nsg1'
  location: location
  properties: {
    securityRules: [
      {
        name: 'AllowSSH'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '22'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 100
          direction: 'Inbound'
        }
      }
    ]
  }
}

// resource kv 'Microsoft.KeyVault/vaults@2021-11-01-preview' = {
//   name: 'keyVault'
//   location: location
//   properties: {
//     createMode: 'recover'
//     enabledForDiskEncryption: true
//     enabledForTemplateDeployment: true
//     tenantId: subscription().tenantId
//     enableSoftDelete: true
//     softDeleteRetentionInDays: 90
//     accessPolicies: [
//       {
//         objectId: 'a0c0cd07-ecb6-40bc-8a09-8a8b2986ccfe'
//         tenantId: subscription().tenantId
//         permissions: {
//           keys: ['all']
//           secrets: ['all']
//           certificates: ['all']
//         }
//       }
//     ]
//     sku: {
//       name: 'standard'
//       family: 'A'
//     }
//     networkAcls: {
//       defaultAction: 'Allow'
//       bypass: 'AzureServices'
//     }
//   }
// }

resource networkInterface 'Microsoft.Network/networkInterfaces@2023-04-01' = {
  name: networkInterfaceName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: subnet1.id
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
  name: vmName
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
      adminPassword: testlog
      linuxConfiguration: ((authenticationType == 'password') ? null : linuxConfiguration)
    }
    storageProfile: {
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: osDiskType
        }
        deleteOption: 'Delete'
      }
      imageReference: imageReference[ubuntuOSVersion]
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
    userData: userData
    securityProfile: ((securityType == 'TrustedLaunch') ? securityProfileJson : null)
  }
}

output vmId string = vm.id
output vmName string = vm.name
output nicPublicIp string = publicIPAddress.properties.ipAddress
output nicPrivateIp string = networkInterface.properties.ipConfigurations[0].properties.privateIPAddress
output hostname string = publicIPAddress.properties.dnsSettings.fqdn
output publicSsh string = 'ssh ${adminUsername}@${publicIPAddress.properties.dnsSettings.fqdn}'
output privateSsh string = 'ssh ${adminUsername}@${networkInterface.properties.ipConfigurations[0].properties.privateIPAddress}'

