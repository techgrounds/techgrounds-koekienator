param nsgName string

resource nsg 'Microsoft.Network/networkSecurityGroups@2023-04-01' existing = {
  name: nsgName
}

resource nsgRuleGatewayManager 'Microsoft.Network/networkSecurityGroups/securityRules@2023-04-01' = {
  parent: nsg
  name: 'GatewayManager'
  properties: {
    description: 'These tcp ports are required for a standard_v2 application gateway. (range: 65200-65535)'
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '65200-65535'
    sourceAddressPrefix: 'GatewayManager'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 1000
    direction: 'Inbound'
  }
}

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
    priority: 4094
    direction: 'Inbound'
  }     
}
