// Main bicep file, will load modules
// Default landing page Bicep resources, check references in left menu https://learn.microsoft.com/en-us/azure/templates/

  // param file? probably
  // https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/parameter-files?tabs=Bicep

  // param policies?
  // https://learn.microsoft.com/en-us/azure/governance/policy/assign-policy-bicep?tabs=azure-powershell

  // param location = resourceGroup.location

  // Tags
  // https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/tag-resources-bicep
  

// module storageAccount 'modules/storageAccount.bicep' = {
  // Define the resource in modules/storageAccount.bicep
// }
  
// module webServer 'modules/virtualMachine.bicep' = {
  // Define the resource in modules/virtualMachine.bicep
// }

// module managementServer 'modules/virtualMachine.bicep' = {
  // Define the resource in modules/virtualMachine.bicep
// }

// // Need to find out how these work in Bicep
// Module Peering?\
  // Define resource in network.bicep?
  // Connect Vnet 1 and 2

// Module vaults
  // Snapshot? Standard tier?

// Module KeyVault
  // Define in keyVault.bicep or main.bicep?
  // https://learn.microsoft.com/en-us/azure/templates/microsoft.keyvault/vaults?pivots=deployment-language-bicep
  // Store SSH key for webserver
  // Storage SSH key for managementserver

// Module RBAC (see alternatives?)
  // https://learn.microsoft.com/nl-nl/azure/azure-resource-manager/bicep/scenarios-rbac
  // Admin account
  // Extend in future?

