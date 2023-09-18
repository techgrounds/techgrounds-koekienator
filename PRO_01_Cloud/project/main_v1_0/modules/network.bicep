// Param for the location
param location string 

// Params for the Virtual Network
param vnetNetworkName string
param vnetAddressPrefix string

// Params for the Subnet
param subnetName string
param subnetAddressPrefix string

// Params for the Network Security Group
param networkSecurityGroupName string
param allowedSSHIp string = '*'

// The NSG
resource subnetNsg 'Microsoft.Network/networkSecurityGroups@2023-04-01' = {
  name: networkSecurityGroupName
  location: location
}

// rule to allow certain SSH connections
resource SshRule 'Microsoft.Network/networkSecurityGroups/securityRules@2023-04-01' = {
  parent: subnetNsg
  name: 'AllowSSH'
  properties: {
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '22'
    sourceAddressPrefix: allowedSSHIp
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 100
    direction: 'Inbound'
  }     
}

// rule to allow Https
resource HttpsRule 'Microsoft.Network/networkSecurityGroups/securityRules@2023-04-01' = {
  parent: subnetNsg
  name: 'AllowHttp'
  properties: {
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '80'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 101
    direction: 'Inbound'
  }     
}

// Rule to deny all access
resource DenyAllRule 'Microsoft.Network/networkSecurityGroups/securityRules@2023-04-01' = {
  parent: subnetNsg
  name: 'DenyAllInbound'
  properties: {
    protocol: '*'
    sourcePortRange: '*'
    destinationPortRange: '*'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Deny'
    priority: 4096
    direction: 'Inbound'
  }     
}

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
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: subnetAddressPrefix
          networkSecurityGroup: {
            id: subnetNsg.id
          }
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
    ]
    enableDdosProtection: false
  }
}

// Subnet
resource subnet 'Microsoft.Network/virtualNetworks/subnets@2023-04-01' = {
  name: subnetName
  parent: vnet
  properties: {
    addressPrefix: subnetAddressPrefix
    networkSecurityGroup: {
      id: subnetNsg.id
    }
  }
}


output virtualNetworkId string = vnet.id
output SubnetId string = subnet.id
output subnetNsgId string = subnetNsg.id
