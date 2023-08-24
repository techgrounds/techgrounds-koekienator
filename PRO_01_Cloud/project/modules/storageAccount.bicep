// Will be the storageAccount module
// - StorageAccount
//   - Module blob storage (postDeploymentScripts)
//     - script install dependencies
//     - script set-up Apache
//     - script backup


// // THIS IS AN EXAMPLE FROM THE BICEP STORAGE ACCOUNT PAGE
// https://learn.microsoft.com/en-us/azure/templates/microsoft.storage/storageaccounts/blobservices?pivots=deployment-language-bicep

// resource symbolicname 'Microsoft.Storage/storageAccounts/blobServices@2022-09-01' = {
//   name: 'default'
//   parent: resourceSymbolicName
//   properties: {
//     automaticSnapshotPolicyEnabled: bool
//     changeFeed: {
//       enabled: bool
//       retentionInDays: int
//     }
//     containerDeleteRetentionPolicy: {
//       allowPermanentDelete: bool
//       days: int
//       enabled: bool
//     }
//     cors: {
//       corsRules: [
//         {
//           allowedHeaders: [
//             'string'
//           ]
//           allowedMethods: [
//             'string'
//           ]
//           allowedOrigins: [
//             'string'
//           ]
//           exposedHeaders: [
//             'string'
//           ]
//           maxAgeInSeconds: int
//         }
//       ]
//     }
//     defaultServiceVersion: 'string'
//     deleteRetentionPolicy: {
//       allowPermanentDelete: bool
//       days: int
//       enabled: bool
//     }
//     isVersioningEnabled: bool
//     lastAccessTimeTrackingPolicy: {
//       blobType: [
//         'string'
//       ]
//       enable: bool
//       name: 'AccessTimeTracking'
//       trackingGranularityInDays: int
//     }
//     restorePolicy: {
//       days: int
//       enabled: bool
//     }
//   }
// }
