// Param for the location
param location string 

// Params for the Virtual Network
param vnetNetworkName string
param vnetAddressPrefix string

@description('Number of subnets you want to create')
@minValue(1)
@maxValue(10)
param numberOfSubnets int

// Params for the Subnet
@description('list of names for the subnets')
param subnetName array
@description('list of address prefixes for the subnet')
param subnetAddressPrefix array

// Vnet
resource vnet 'Microsoft.Network/virtualNetworks@2023-04-01' = {
  name: vnetNetworkName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
    subnets: [for i in range(0, numberOfSubnets): {
      name: '${subnetName[i]}'
      properties: {
        addressPrefix: subnetAddressPrefix[i]
        networkSecurityGroup: {
          id: subnetNsgLoop[i].id
        }
      }
    }]
    enableDdosProtection: false
  }
}

// Subnet
// resource subnets 'Microsoft.Network/virtualNetworks/subnets@2023-04-01' = [for i in range(0, numberOfSubnets): {
//   name: '${subnetName[i]}'
//   parent: vnet
//   properties: {
//     addressPrefix: subnetAddressPrefix[i]
//     networkSecurityGroup: {
//       id: subnetNsgLoop[i].id
//     }
//   }
// }]

// The NSG
resource subnetNsgLoop 'Microsoft.Network/networkSecurityGroups@2023-04-01' = [for subnet in subnetName: {
  name: '${subnet}-nsg'
  location: location
}]

output vnetName string = vnet.name

output subnet array = [for i in range(0,numberOfSubnets): {
  id: vnet.properties.subnets[i].id
  name: vnet.properties.subnets[i].name
}]

output nsg array = [for i in range(0,numberOfSubnets): {
  id: subnetNsgLoop[i].id
  name: subnetNsgLoop[i].name
}]
