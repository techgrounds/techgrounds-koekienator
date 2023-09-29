// Param for the location
param location string 

// Params for the webserver
param webserverVnetName string 
param webserverVnetAddressPrefix string
param subnetVmssAdressPrefix string 
param subnetAppGwAdressPrefix string 
param vmssTrustedIpAdressess string

// params for the managementserver
param managementerverVnetName string 
param managementserverVnetAddressPrefix string 
param subnetManagementAdressPrefix string
param managementTrustedIpAdresess string

// variables webserver
var subnetVmssName = 'webserver'
var nsgVmssName = '${subnetVmssName}-NSG' 
var subnetAppGwName = 'appGateway'
var nsgAppGwName = '${subnetAppGwName}-NSG'

// variables managementserver
var subnetManagementName = 'managementserver'
var nsgManagementName = '${subnetManagementName}-NSG'

// Vnet
resource webserverVnet 'Microsoft.Network/virtualNetworks@2023-04-01' = {
  name: webserverVnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        webserverVnetAddressPrefix
      ]
    }
    // subnets: [subnetVmss, subnetAppGw]
    enableDdosProtection: false
  }
}

resource managementserverVnet 'Microsoft.Network/virtualNetworks@2023-04-01' = {
  name: managementerverVnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        managementserverVnetAddressPrefix
      ]
    }
    // subnets: [subnetManagement]
    enableDdosProtection: false
  }
}


resource subnetVmss 'Microsoft.Network/virtualNetworks/subnets@2023-04-01' = {
  name: subnetVmssName
  parent: webserverVnet
  properties: {
    addressPrefix: subnetVmssAdressPrefix
    networkSecurityGroup: {
      id: nsgVmss.id
    }
  }
}

resource subnetAppGw 'Microsoft.Network/virtualNetworks/subnets@2023-04-01' = {
  name: subnetAppGwName
  parent: webserverVnet
  properties: {
    addressPrefix: subnetAppGwAdressPrefix
    networkSecurityGroup: {
      id: nsgAppGw.id
    }
  }
}

resource subnetManagement 'Microsoft.Network/virtualNetworks/subnets@2023-04-01' = {
  name: subnetManagementName
  parent: managementserverVnet
  properties: {
    addressPrefix: subnetManagementAdressPrefix
    networkSecurityGroup: {
      id: nsgManagement.id
    }
  }
}

// The NSG
resource nsgVmss 'Microsoft.Network/networkSecurityGroups@2023-04-01' = {
  name: nsgVmssName
  location: location
}

resource nsgAppGw 'Microsoft.Network/networkSecurityGroups@2023-04-01' = {
  name: nsgAppGwName
  location: location
}

resource nsgManagement 'Microsoft.Network/networkSecurityGroups@2023-04-01' = {
  name: nsgManagementName
  location: location
}

// appgateway rules
resource nsgRuleGatewayManager 'Microsoft.Network/networkSecurityGroups/securityRules@2023-04-01' = {
  parent: nsgAppGw
  name: 'GatewayManager'
  properties: {
    description: 'These tcp ports are required for a standard_v2 application gateway. (range: 65200-65535)'
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '65200-65535'
    sourceAddressPrefix: 'GatewayManager'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 300
    direction: 'Inbound'
  }
}

// vmss rules
// rule to allow certain SSH connections
resource sshTrustedIpAdress 'Microsoft.Network/networkSecurityGroups/securityRules@2023-04-01' = {
  parent: nsgVmss
  name: 'AllowSSH'
  properties: {
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '22'
    sourceAddressPrefix: vmssTrustedIpAdressess
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 100
    direction: 'Inbound'
  }     
}

// rule to allow Https
resource httpRule 'Microsoft.Network/networkSecurityGroups/securityRules@2023-04-01' = {
  parent: nsgVmss
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
  parent: nsgVmss
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
  parent: nsgVmss
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

// managementserver rules
// rule to allow certain SSH connections
resource managementSshTrustedIpAdress 'Microsoft.Network/networkSecurityGroups/securityRules@2023-04-01' = {
  parent: nsgManagement
  name: 'AllowSSH'
  properties: {
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '22'
    sourceAddressPrefix: managementTrustedIpAdresess
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 200
    direction: 'Inbound'
  }     
}

// Rule to deny all access
resource managementDenyAllRule 'Microsoft.Network/networkSecurityGroups/securityRules@2023-04-01' = {
  parent: nsgManagement
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

// VNET ID's
output webVnetId string = webserverVnet.id
output managemetVnetId string = managementserverVnet.id

// VNET NAMES
output webVnetName string = webserverVnet.name
output managementVnetName string = managementserverVnet.name

// SUBNET ID's
output subnetVmssId string = subnetVmss.id
output subnetAppGwId string = subnetAppGw.id
output subnetManagementId string = subnetManagement.id

// NSG ID's
output nsgVmssId string = nsgVmss.id
output nsgAppGwId string = nsgAppGw.id
output nsgManagementId string = nsgManagement.id

// NSG NAMES
output nsgAppGwName string = nsgAppGw.name
output nsgManagementName string = nsgManagement.name
output nsgVmssName string = nsgVmss.name

// output virtualNetworkId string = vnet.id
// output subnetId array = [for i in range(0,numberOfSubnets): {subnetId: subnetsLoop[i].id}]
// output subnetNsgId array = [for i in range(0,numberOfSubnets): {subnetNsgId: subnetNsgLoop[i].id}]
