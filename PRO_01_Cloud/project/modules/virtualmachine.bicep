@description('Location for all resources.')
param location string 

@description('Username for the Virtual Machine.')
param adminUsername string

@description('Type of authentication to use on the Virtual Machine. SSH key is recommended.')
@allowed([
  'sshPublicKey'
  'password'
])
param authenticationType string = 'password'

@description('SSH Key or password for the Virtual Machine. SSH key is recommended.')
@secure()
param adminPasswordOrKey string

param kvName string
param keysPermissions array
param secretsPermissions array

@description('Unique DNS Name for the Public IP used to access the Virtual Machine.')
param dnsLabelPrefix string = toLower('${vmName}-${uniqueString(resourceGroup().id)}')

@description('The Ubuntu version for the VM. This will pick a fully patched image of this given Ubuntu version.')
@allowed([
  'Ubuntu-2004'
])
param ubuntuOSVersion string = 'Ubuntu-2004'

@description('The name of you Virtual Machine.')
param vmName string

@description('The size of the VM')
param vmSize string = 'Standard_B1ls'

@description('The subnet ID you want to deploy to')
param subnetId string 

@description('The NSG ID you want to deploy to')
param networkSecurityGroupId string

@description('Security Type of the Virtual Machine.')
@allowed([
  'Standard'
  'TrustedLaunch'
])
param securityType string = 'TrustedLaunch'

var imageReference = {
  'Ubuntu-2004': {
    publisher: 'canonical'
    offer: '0001-com-ubuntu-server-focal'
    sku: '20_04-lts-gen2'
    version: 'latest'
  }
}

var publicIPAddressName = '${vmName}PublicIP'
var networkInterfaceName = '${vmName}NetInt'
var osDiskType = 'Standard_LRS'

var linuxConfiguration = {
  disablePasswordAuthentication: true
  ssh: {
    publicKeys: [
      {
        path: '/home/${adminUsername}/.ssh/authorized_keys'
        keyData: adminPasswordOrKey
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

// var managedIdentityName = '${vmName}-vault'

// resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
//   name: managedIdentityName
//   location: location
// }

// module newKvAccessPolicy 'kv_extensions/kvpolicies.bicep' = {
//   name: '${vmName}-Policy'
//   params: {
//     keysPermissions: keysPermissions
//     kvName: kvName
//     location: location
//     managedIdentityName: managedIdentity.properties.principalId
//     secretsPermissions:secretsPermissions
//   }
// }

// module addLogin 'kv_extensions/secrets.bicep' = {
//   name: '${vm.name}-Login'
//   params: {
//     kvName: kvName
//     secretName: adminUsername
//     secretValue: adminPasswordOrKey
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
            id: subnetId
          }
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddress.id
          }
        }
      }] 
      networkSecurityGroup: {
        id: networkSecurityGroupId
      }
  }
}


resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2023-04-01' = {
  name: publicIPAddressName
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    publicIPAllocationMethod: 'Dynamic'
    publicIPAddressVersion: 'IPv4'
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
  // identity: {
  //   type:'UserAssigned'
  //   userAssignedIdentities: {
  //     '${managedIdentity.id}': {}
    // }
  // }
  location: location
  
  // zones: availabilityZones
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      adminPassword: adminPasswordOrKey
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
        }
      ]
    }
    securityProfile: ((securityType == 'TrustedLaunch') ? securityProfileJson : null)
  }
}

output adminUsername string = adminUsername
output nicPrivateIp string = networkInterface.properties.ipConfigurations[0].properties.privateIPAddress
output hostname string = publicIPAddress.properties.dnsSettings.fqdn
output sshCommand string = 'ssh ${adminUsername}@${publicIPAddress.properties.dnsSettings.fqdn}'
