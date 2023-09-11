param location string
param storageAccountName string
param storageAccountSkuName string
param blobContainerName string

// StorageAccount (WORKS)
@description('The storage account for the blob container for post deployment scripts')
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageAccountSkuName
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Cool'
    supportsHttpsTrafficOnly: true
  }
}

// Blob container for scripts (WORKS)
@description('The blob container for post deployment scripts, only deploys IF storageaccount is availible')
resource storageBlobScripts 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = {
  name: '${storageAccountName}/default/${blobContainerName}'
  dependsOn: [
    storageAccount
  ]
}
