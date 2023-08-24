// Will be the network configuration, One module for two or create two different with same module?

// - Peering
//   - vnet webserver <- vnet managementserver

// - Network
//   - Vnet 'app-prd-vnet'
//     - Public IP 
//     - Private IP (10.10.10.0/24)
//       - NSG (port )
//       - Subnet IP
//   - Vnet 'management-prd-vnet'
//     - Public IP
//     - Private IP (10.20.20.0/24)
//       - Subnet IP

// // THIS IS AN EXAMPLE FROM THE BICEP NETWORK PAGE
// https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/scenarios-virtual-networks
// maybe param files for the two different networks?

// var virtualNetworkName = 'my-vnet'
// var subnet1Name = 'Subnet-1'
// var subnet2Name = 'Subnet-2'


// resource virtualNetwork 'Microsoft.Network/virtualNetworks@2019-11-01' = {
//   name: virtualNetworkName
//   location: location
//   properties: {
//     addressSpace: {
//       addressPrefixes: [
//         '10.0.0.0/16'
//       ]
//     }
//     subnets: [
//       {
//         name: subnet1Name
//         properties: {
//           addressPrefix: '10.0.0.0/24'
//         }
//       }
//       {
//         name: subnet2Name
//         properties: {
//           addressPrefix: '10.0.1.0/24'
//         }
//       }
//     ]
//   }

//   resource subnet1 'subnets' existing = {
//     name: subnet1Name
//   }

//   resource subnet2 'subnets' existing = {
//     name: subnet2Name
//   }
// }

// output subnet1ResourceId string = virtualNetwork::subnet1.id
// output subnet2ResourceId string = virtualNetwork::subnet2.id
