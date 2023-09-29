@description('Location for the VM, only certain regions support Availability Zones.')
param location string

// KV related params
param kvName string
param secretsPermissions array
param keysPermissions array
param certificatesPermissions array

// Network related params
param subnetId string
param nsgName string
// param asgName string
param trustedIpAddress string
param appGatwayIp string

// AppGateway related params
param backendpoolId string

// Vmss related params
@description('String used as a base for naming resources. Must be 3-61 characters in length and globally unique across Azure. A hash is prepended to this string for some resources, and resource-specific information is appended.')
@maxLength(61)
param vmssName string

// Vm related params
@description('Number of VM instances (100 or less).')
@minValue(1)
@maxValue(100)
param instanceCount int = 1

@description('The Ubuntu version for the VM. This will pick a fully patched image of this given Ubuntu version.')
@allowed([
  'Ubuntu-2004'
  'Ubuntu-2204'
])
param ubuntuOSVersion string = 'Ubuntu-2204'

@description('Admin username on all VMs')
param adminUsername string 

@description('Type of authentication to use on the Virtual Machine. SSH key is recommended.')
@allowed([
  'sshPublicKey'
  'password'
])
param authenticationType string = 'sshPublicKey'

@description('SSH Key for the Virtual Machine.')
@secure()
param adminKey string

param userData string

@description('The size of the VM')
param vmSize string = 'Standard_B1ls'

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
  'Ubuntu-2204': {
    publisher: 'Canonical'
    offer: '0001-com-ubuntu-server-jammy'
    sku: '22_04-lts-gen2'
    version: 'latest'
  }
}

var osDiskType = 'Standard_LRS'
var linuxConfiguration = {
  disablePasswordAuthentication: true
  ssh: {
    publicKeys: [
      {
        path: '/home/${adminUsername}/.ssh/authorized_keys'
        keyData: adminKey
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

resource kv 'Microsoft.KeyVault/vaults@2023-02-01' existing = {
  name: kvName
}

resource kvAccessPolicy 'Microsoft.KeyVault/vaults/accessPolicies@2023-02-01' = {
  name: 'add'
  parent: kv
  properties: {
    accessPolicies: [
      {
        applicationId: vmss.identity.principalId
        objectId: vmss.identity.principalId
        permissions: {
          certificates: certificatesPermissions
          keys: keysPermissions
          secrets: secretsPermissions
        }
        tenantId: vmss.identity.tenantId
      }
    ]
  }
}

resource nsg 'Microsoft.Network/networkSecurityGroups@2023-04-01' existing = {
  name: nsgName
}

resource asg 'Microsoft.Network/applicationSecurityGroups@2023-04-01' = {
  name: '${vmssName}-asg'
  location: location
}

// Rule allow SSH via management server
resource sshRule 'Microsoft.Network/networkSecurityGroups/securityRules@2023-04-01' = {
  parent: nsg
  name: 'AllowSsh'
  properties: {
    description: 'Allows ssh connection from the managementserver'
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '22'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: trustedIpAddress
    access: 'Allow'
    priority: 101
    direction: 'Inbound'
  }    
}

// rule to allow Http
resource httpRule 'Microsoft.Network/networkSecurityGroups/securityRules@2023-04-01' = {
  parent: nsg
  name: 'AllowHttp'
  properties: {
    description: 'Allows the appgateway to connect with the vmss'
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '80'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: appGatwayIp
    access: 'Allow'
    priority: 102
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
    priority: 103
    direction: 'Inbound'
  }     
}

resource vmss 'Microsoft.Compute/virtualMachineScaleSets@2023-03-01' = {
  name: vmssName
  location: location
  sku: {
    name: vmSize
    tier: 'standard'
    capacity: instanceCount
  }
  identity: {
    type: 'SystemAssigned'
  }
  zones: ['1', '2']
  properties: {
    overprovision: false
    upgradePolicy: {
      mode: 'Automatic'
    }
    zoneBalance: true
    singlePlacementGroup: false
    platformFaultDomainCount: 1
    automaticRepairsPolicy: {
      enabled: true
      gracePeriod: 'PT30M'
    }
    virtualMachineProfile: {
      osProfile: {
        computerNamePrefix: vmssName
        adminUsername: adminUsername
        adminPassword: adminKey
        linuxConfiguration: ((authenticationType == 'password') ? null : linuxConfiguration)
      }
      userData: userData
      storageProfile: {
        osDisk: {
          caching: 'ReadWrite'
          createOption: 'FromImage'
          managedDisk: {
            storageAccountType: osDiskType
          }
        }
        imageReference: imageReference[ubuntuOSVersion]
      }
      securityProfile: ((securityType == 'TrustedLaunch') ? securityProfileJson : null)
      networkProfile: {
        // healthProbe: {
        //   id: 
        // }
        networkInterfaceConfigurations: [
          {
            name: '${vmssName}-nic'
            properties: {
              primary: true
              ipConfigurations: [
                {
                  name: 'vmssIpConfig'
                  properties: {
                    subnet: {
                      id: subnetId
                    }
                    applicationSecurityGroups: [
                      {
                        id: asg.id
                      }
                    ]
                    applicationGatewayBackendAddressPools: [
                      {
                        id: backendpoolId
                      }
                    ]
                  }
                }
              ]
            }
          }
        ]
      }
      extensionProfile: {
        extensions: [
          {
            name: 'HealthExtension'
            properties: {
              enableAutomaticUpgrade: true
              autoUpgradeMinorVersion: true
              publisher: 'Microsoft.ManagedServices'
              type: 'ApplicationHealthLinux'
              typeHandlerVersion: '1.0'
              settings: {
                protocol: 'http'
                port: 80
              }
            }
          }
        ]
      }
    }
  }
}

resource autoscalehost 'Microsoft.Insights/autoscalesettings@2022-10-01' = {
  name: 'autoscalehost'
  location: location
  properties: {
    name: 'autoscalehost'
    targetResourceUri: vmss.id
    enabled: true
    profiles: [
      {
        name: 'vmmsAutoScaleProfile1'
        capacity: {
          minimum: '1'
          maximum: '3'
          default: '1'
        }
        rules: [
          {
            metricTrigger: {
              metricName: 'Percentage CPU'
              metricResourceUri: vmss.id
              timeGrain: 'PT1M'
              statistic: 'Average'
              timeWindow: 'PT5M'
              timeAggregation: 'Average'
              operator: 'GreaterThan'
              threshold: 75
            }
            scaleAction: {
              direction: 'Increase'
              type: 'ChangeCount'
              value: '1'
              cooldown: 'PT5M'
            }
          }
          {
            metricTrigger: {
              metricName: 'Percentage CPU'
              metricResourceUri: vmss.id
              timeGrain: 'PT1M'
              statistic: 'Average'
              timeWindow: 'PT5M'
              timeAggregation: 'Average'
              operator: 'LessThan'
              threshold: 30
            }
            scaleAction: {
              direction: 'Decrease'
              type: 'ChangeCount'
              value: '1'
              cooldown: 'PT5M'
            }
          }
        ]
      }
    ]
  }
}

output webserverASG string = asg.name


