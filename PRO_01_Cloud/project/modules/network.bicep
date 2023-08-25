param location string = 'westeurope'

//Params for webserverVnet children, and NSG
param webserverVnetName string = 'app-prd-vnet'
param webserverVnetSubnetName string = 'webserver-subnet'
param webserverVnetAddressPrefix string = '10.10.0.0/16'
param webserverVnetSubnetAddressPrefix string = '10.10.10.0/24'
param webserverNsgName string = '${webserverVnetSubnetName}NSG'

//Params for managementVnet children, and NSG
param managementVnetName string = 'management-prd-vnet'
param managementVnetSubnetName string = 'managementserver-subnet'
param managementPeerToWebserverName string = 'management-peer-Webserver'
param managementVnetAddressPrefix string = '10.20.0.0/16'
param managementVnetSubnetAddressPrefix string = '10.20.20.0/24'
param managementServerNsgName string = '${managementVnetSubnetName}NSG'
param webserverVnetExternalID string = '/subscriptions/42d4abc3-eb16-4e20-997a-2a4e28016d24/resourceGroups/koekbiceptestomgeving/providers/Microsoft.Network/virtualNetworks/${webserverVnetName}'

// Webserver NSG + Rules
resource webserverNsg 'Microsoft.Network/networkSecurityGroups@2023-04-01' = {
  name: webserverNsgName
  location: location
}

resource webserverSshRule 'Microsoft.Network/networkSecurityGroups/securityRules@2023-04-01' = {
  parent: webserverNsg
  name: 'AllowSSH'
  properties: {
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '22'
    sourceAddressPrefix: managementVnetSubnetAddressPrefix
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 100
    direction: 'Inbound'
  }     
}

resource webserverHttpsRule 'Microsoft.Network/networkSecurityGroups/securityRules@2023-04-01' = {
  parent: webserverNsg
  name: 'AllowHttps'
  properties: {
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '443'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 101
    direction: 'Inbound'
  }     
}

resource webserverDenyAllRule 'Microsoft.Network/networkSecurityGroups/securityRules@2023-04-01' = {
  parent: webserverNsg
  name: 'DenyAllInbound'
  properties: {
    protocol: '*'
    sourcePortRange: '*'
    destinationPortRange: '22'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 4096
    direction: 'Inbound'
  }     
}

// Managementserver NSG + Rules
resource managementNsg 'Microsoft.Network/networkSecurityGroups@2023-04-01' = {
  name: managementServerNsgName
  location: location
}

resource managementserverSshRule 'Microsoft.Network/networkSecurityGroups/securityRules@2023-04-01' = {
  parent: managementNsg
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

resource managementserverHttpsRule 'Microsoft.Network/networkSecurityGroups/securityRules@2023-04-01' = {
  parent: managementNsg
  name: 'AllowHTTPS'
  properties: {
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '443'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 101
    direction: 'Inbound'
  }
}

resource managementserverDenyAllRule 'Microsoft.Network/networkSecurityGroups/securityRules@2023-04-01' = {
  parent: managementNsg
  name: 'DenyAllInbound'
  properties: {
    protocol: '*'
    sourcePortRange: '*'
    destinationPortRange: '22'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 4096
    direction: 'Inbound'
  }
}

// Webserver Vnet + Subnet
resource webserverVnet 'Microsoft.Network/virtualNetworks@2023-04-01' = {
  name: webserverVnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        webserverVnetAddressPrefix
      ]
    }
    subnets: [
      {
        name: webserverVnetSubnetName
        properties: {
          addressPrefix: webserverVnetSubnetAddressPrefix
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
    ]
    enableDdosProtection: false
  }
}

resource webserverVnetSubnet 'Microsoft.Network/virtualNetworks/subnets@2023-04-01' = {
  name: webserverVnetSubnetName
  parent: webserverVnet
  properties: {
    addressPrefix: webserverVnetSubnetAddressPrefix
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    networkSecurityGroup: {
      id: webserverNsg.id
    }
  }
}

// Management Vnet + Subnet
resource managementVnet 'Microsoft.Network/virtualNetworks@2023-04-01' = {
  name: managementVnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        managementVnetAddressPrefix
      ]
    }
    subnets: [
      {
        name: managementVnetSubnetName
        properties: {
          addressPrefix: managementVnetSubnetAddressPrefix
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
    ]
    virtualNetworkPeerings: [
      {
        name: managementPeerToWebserverName
        properties: {
          peeringState: 'Connected'
          peeringSyncLevel: 'FullyInSync'
          remoteVirtualNetwork: {
            id: webserverVnetExternalID
          }
          allowVirtualNetworkAccess: true
          allowForwardedTraffic: false
          allowGatewayTransit: false
          useRemoteGateways: false
          doNotVerifyRemoteGateways: false
          remoteAddressSpace: {
            addressPrefixes: [
              webserverVnetAddressPrefix
            ]
          }
          remoteVirtualNetworkAddressSpace: {
            addressPrefixes: [
              webserverVnetAddressPrefix
            ]
          }
        }
        type: 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings'
      }
    ]
    enableDdosProtection: false
  }
}

resource managementVnetSubnet 'Microsoft.Network/virtualNetworks/subnets@2023-04-01' = {
  name: managementVnetSubnetName
  parent: managementVnet
  properties: {
    addressPrefix: managementVnetSubnetAddressPrefix
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    networkSecurityGroup: {
      id: managementNsg.id
    }
  }
}

// Outputs if needed

