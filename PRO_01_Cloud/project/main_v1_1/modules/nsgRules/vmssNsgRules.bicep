param nsgName string
param trustedIpAdresses string

resource nsg 'Microsoft.Network/networkSecurityGroups@2023-04-01' existing = {
  name: nsgName
}

// rule to allow certain SSH connections
resource sshTrustedIpAdress 'Microsoft.Network/networkSecurityGroups/securityRules@2023-04-01' = {
  parent: nsg
  name: 'AllowSSH'
  properties: {
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '22'
    sourceAddressPrefix: trustedIpAdresses
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 100
    direction: 'Inbound'
  }     
}

// rule to allow Https
resource httpRule 'Microsoft.Network/networkSecurityGroups/securityRules@2023-04-01' = {
  parent: nsg
  name: 'AllowHttp'
  properties: {
    description: 'Allows the appgateway to connect with the vmss'
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '80'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: 'GatewayManager'
    access: 'Allow'
    priority: 101
    direction: 'Inbound'
  }     
}

resource httpsRule 'Microsoft.Network/networkSecurityGroups/securityRules@2023-04-01' = {
  parent: nsg
  name: 'AllowHttps'
  properties: {
    description: 'Allows connections via https for the website'
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '443 '
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 102
    direction: 'Inbound'
  }     
}

// Rule to deny all access
resource DenyAllRule 'Microsoft.Network/networkSecurityGroups/securityRules@2023-04-01' = {
  parent: nsg
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
