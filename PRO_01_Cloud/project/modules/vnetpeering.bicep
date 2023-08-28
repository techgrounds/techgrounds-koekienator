@description('Set the name of the main vnet for peering')
param vnet1Name string

@description('Set the name of the vnet you want to connect to, must be within same resource group')
param vnet2Name string

@description('Connect two local vnets via peering, must be same resource group!')
resource peeringVnet1andVnet2 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2021-02-01' = {
  name: '${vnet1Name}/vnet-peering-to-${vnet2Name}'
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: false
    allowGatewayTransit: false
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: resourceId(resourceGroup().name, 'Microsoft.Network/virtualNetworks', vnet2Name)
    }
  }
}
