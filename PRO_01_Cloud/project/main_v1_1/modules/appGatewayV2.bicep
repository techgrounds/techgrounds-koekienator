param location string = resourceGroup().location
param applicationGatewayName string

// param virtualNetworkName string
param subnetId string
param nsgName string
param myBackendPool string
// param webserverASG string

// ssl certificate
// param kvUri string
// param kvName string
// param webSslCertificateName string

var publicIPAddressName = '${applicationGatewayName}-PublicIP'
@description('Unique DNS Name for the Public IP used to access the Virtual Machine.')
var dnsLabelPrefix = toLower('${applicationGatewayName}-${uniqueString(resourceGroup().id)}')

resource nsg 'Microsoft.Network/networkSecurityGroups@2023-04-01' existing = {
  name: nsgName
}

// resource asg 'Microsoft.Network/applicationSecurityGroups@2023-04-01' existing = {
//   name: webserverASG
// }

resource nsgRuleHttpInbound 'Microsoft.Network/networkSecurityGroups/securityRules@2023-04-01' = {
  parent: nsg
  name: 'AllowHttpInbound'
  properties: {
    description: 'Allows http for communication with backendpool'
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '80'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 100
    direction: 'Inbound'
  }
}

resource nsgRuleHttpsInbound 'Microsoft.Network/networkSecurityGroups/securityRules@2023-04-01' = {
  parent: nsg
  name: 'AllowHttpsInbound'
  properties: {
    description: 'Allows https for secure access to website'
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '443'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 110
    direction: 'Inbound'
  }
}

// resource nsgRuleWebserverInbound 'Microsoft.Network/networkSecurityGroups/securityRules@2023-04-01' = {
//   parent: nsg
//   name: 'AllowWebserverInbound'
//   properties: {
//     description: 'Allows https for secure access to website'
//     protocol: 'Tcp'
//     sourcePortRange: '*'
//     destinationPortRange: '80, 443'
//     sourceAddressPrefix: '*'
//     destinationAddressPrefix: '*'
//     // destinationApplicationSecurityGroups: [asg]
//     access: 'Allow'
//     priority: 120
//     direction: 'Inbound'
//   }
// }

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
    priority: 130
    direction: 'Inbound'
  }
}


resource nsgRuleHttpOutbound 'Microsoft.Network/networkSecurityGroups/securityRules@2023-04-01' = {
  parent: nsg
  name: 'AllowHttpOutbound'
  properties: {
    description: 'Allow all http requests to appGateway'
    protocol: 'Tcp'
    sourcePortRange: '80'
    destinationPortRange: '*'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 500
    direction: 'Outbound'
  }
}

resource nsgRuleHttpsOutbound 'Microsoft.Network/networkSecurityGroups/securityRules@2023-04-01' = {
  parent: nsg
  name: 'AllowHttpsOutbound'
  properties: {
    description: 'Allows outbound traffic via https'
    protocol: 'Tcp'
    sourcePortRange: '443'
    destinationPortRange: '*'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 510
    direction: 'Outbound'
  }
}

// resource nsgRuleWebserverOutbound 'Microsoft.Network/networkSecurityGroups/securityRules@2023-04-01' = {
//   parent: nsg
//   name: 'AllowWebserverOutbound'
//   properties: {
//     description: ''
//     protocol: 'Tcp'
//     sourcePortRange: '*'
//     destinationPortRange: '*'
//     sourceAddressPrefix: 
//     destinationAddressPrefix: '*'
//     access: 'Allow'
//     priority: 520
//     direction: 'Outbound'
//   }
// }

resource nsgRuleAllowInternet 'Microsoft.Network/networkSecurityGroups/securityRules@2023-04-01' = {
  parent: nsg
  name: 'AllowInternet'
  properties: {
    description: 'Allows incomming internet traffic'
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '*'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: 'Internet'
    access: 'Allow'
    priority: 530
    direction: 'Outbound'
  }
}

resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2023-04-01' = {
  name: publicIPAddressName
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    dnsSettings: {
      domainNameLabel: dnsLabelPrefix
    }
  }
}

// resource sslCertificate 'Microsoft.Web/certificates@2022-09-01' = {
//   name: 'webserverCert'
//   location: location
// }

resource applicationGateWay 'Microsoft.Network/applicationGateways@2023-04-01' = {
  name: applicationGatewayName
  location: location
  properties: {
    sku: {
      name: 'Standard_v2'
      tier: 'Standard_v2'
    }
    gatewayIPConfigurations: [
      {
        name: 'appGatewayIpConfig'
        properties: {
          subnet: {
            id: subnetId
          }
        }
      }
    ]
    sslCertificates: [
      {
        name: 'webserverCertificate'
        properties: {
          // keyVaultSecretId: '${kvUri}secrets/${webSslCertificateName}'
          data: loadFileAsBase64('../cert/webcert.pfx')
          password: ''
        }
      }
    ]
    frontendIPConfigurations: [
      {
        name: 'appGatewayFrontendIP'
        properties: {
          publicIPAddress: {
            id: resourceId('Microsoft.Network/publicIPAddresses', publicIPAddressName)
          }
        }
      }
    ]
    frontendPorts: [
      {
        name: 'port_80'
        properties: {
          port: 80
        }
      }
      {
        name: 'appGatewayFrontendPort'
        properties: {
          port: 443
        }
      }
    ]
    backendAddressPools: [
      {
        name: myBackendPool
      }
    ]
    backendHttpSettingsCollection: [
      {
        name: 'appGatewayBackendHttpSettings'
        properties: {
          port: 80
          protocol: 'Http'
          cookieBasedAffinity: 'Disabled'
        }
      }
    ]

    httpListeners: [
      {
        name: 'appGatewayHttpListener'
        properties: {
          frontendIPConfiguration: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendIPConfigurations', applicationGatewayName, 'appGatewayFrontendIP')
          }
          frontendPort: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendPorts', applicationGatewayName, 'appGatewayFrontendPort')
          }
          protocol: 'Https'
          sslCertificate: {
            id: resourceId('Microsoft.Network/applicationGateways/sslCertificates', applicationGatewayName, 'webserverCertificate')
          }
        }
      }
    ]
    
    requestRoutingRules: [
      {
        name: 'rule1'
        properties: {
          priority: 100
          ruleType: 'Basic'
          httpListener: {
            id: resourceId('Microsoft.Network/applicationGateways/httpListeners', applicationGatewayName, 'appGatewayHttpListener')
          }
          backendAddressPool: {
            id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools', applicationGatewayName, myBackendPool)
          }
          backendHttpSettings: {
            id: resourceId('Microsoft.Network/applicationGateways/backendHttpSettingsCollection', applicationGatewayName, 'appGatewayBackendHttpSettings')
          }
        }
      }
      // {
      //   name: 'httpToHttps'
      //   properties: {
      //     priority: 100
      //     ruleType: 'PathBasedRouting'
      //     httpListener: {
      //       id: resourceId('Microsoft.Network/applicationGateways/httpListeners', applicationGateWayName, 'httpListener')
      //     }
      //     backendAddressPool: {
      //       id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools', applicationGateWayName, myBackendPool)
      //     }
      //     backendHttpSettings: {
      //       id: resourceId('Microsoft.Network/applicationGateways/backendHttpSettingsCollection', applicationGateWayName, 'backendHttpSettings')
      //     }
      //     redirectConfiguration: {
            
      //     }
      //   }
      // }
    ]
    enableHttp2: false
    autoscaleConfiguration: {
      minCapacity: 0
      maxCapacity: 10
    }
  }
  dependsOn: [
    nsgRuleGatewayManager
    publicIPAddress
  ]
}

output backendpoolId string = applicationGateWay.properties.backendAddressPools[0].id
output appGatwayIp string = publicIPAddress.properties.ipAddress
// output applicationUrl string = uri('http://${publicIPAddress.properties.dnsSettings.fqdn}', '/Website')
