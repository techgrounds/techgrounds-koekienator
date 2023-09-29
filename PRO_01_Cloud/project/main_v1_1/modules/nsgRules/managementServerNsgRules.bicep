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
    priority: 200
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
    priority: 4095
    direction: 'Inbound'
  }     
}
