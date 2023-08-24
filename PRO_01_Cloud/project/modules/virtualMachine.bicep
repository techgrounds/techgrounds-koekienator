// Will be the virtualMachine module
// - Web Server (Low cost, SSH req.)
//   - SSH connection only via management server
//   - Public IP (or public IP via Management Server?)
//     - Private IP (10.10.10.0/24), same for subnet
//     - Ubuntu Server 20.04 LTS Gen 1 (~$4.40 west europe)(~$4.30 uk south)
//       - West europe only availability zone 2, UK South 1/2/3
//       - Standard_B1ls
//       - SSH login via management server
//         - Save KeyPair in KeyVault, only access via management server?
//       - Inbound port only 22
//       - Standard SSD
//       - Key management 'platform-managed key'
//       - Enable system assigned managed identity (RBAC)
//       - Enable backup (must read options to clarify what tier for 7 day back up storage)
//       - Custom data and cloud init (? maybe instead of backup, we run a back up script?)

// - Management server (Low cost, SSH req.)
//   - Access via Public IP, trusted location
//   - Public IP
//   - Private IP (10.20.20.0/24), same for subnet
//   - Ubuntu Server 20.04 LTS Gen 1 (~$4.40 west europe)(~$4.30 uk south)
//     - West europe only availability zone 2, UK South 1/2/3
//     - Standard_B1ls
//     - SSH login via management server
//       - Save KeyPair in KeyVault, only access via management server?
//     - Inbound port only 22
//     - Standard SSD
//     - Key management 'platform-managed key'
//     - Enable system assigned managed identity (RBAC)

// // THIS IS AN EXAMPLE FROM THE BICEP VIRTUAL MACHINE PAGE
// https://learn.microsoft.com/nl-nl/azure/templates/microsoft.compute/virtualmachines?pivots=deployment-language-bicep
// Need to trim exaple for parts I actually need
// Make vars for different configs or make two different VM resources? 
// Maybe param files for the two configs with different names?

// resource symbolicname 'Microsoft.Compute/virtualMachines@2023-03-01' = {
//   name: 'string'
//   location: 'string'
//   tags: {
//     tagName1: 'tagValue1'
//     tagName2: 'tagValue2'
//   }
//   extendedLocation: {
//     name: 'string'
//     type: 'EdgeZone'
//   }
//   identity: {
//     type: 'string'
//     userAssignedIdentities: {}
//   }
//   plan: {
//     name: 'string'
//     product: 'string'
//     promotionCode: 'string'
//     publisher: 'string'
//   }
//   properties: {
//     additionalCapabilities: {
//       hibernationEnabled: bool
//       ultraSSDEnabled: bool
//     }
//     applicationProfile: {
//       galleryApplications: [
//         {
//           configurationReference: 'string'
//           enableAutomaticUpgrade: bool
//           order: int
//           packageReferenceId: 'string'
//           tags: 'string'
//           treatFailureAsDeploymentFailure: bool
//         }
//       ]
//     }
//     availabilitySet: {
//       id: 'string'
//     }
//     billingProfile: {
//       maxPrice: json('decimal-as-string')
//     }
//     capacityReservation: {
//       capacityReservationGroup: {
//         id: 'string'
//       }
//     }
//     diagnosticsProfile: {
//       bootDiagnostics: {
//         enabled: bool
//         storageUri: 'string'
//       }
//     }
//     evictionPolicy: 'string'
//     extensionsTimeBudget: 'string'
//     hardwareProfile: {
//       vmSize: 'string'
//       vmSizeProperties: {
//         vCPUsAvailable: int
//         vCPUsPerCore: int
//       }
//     }
//     host: {
//       id: 'string'
//     }
//     hostGroup: {
//       id: 'string'
//     }
//     licenseType: 'string'
//     networkProfile: {
//       networkApiVersion: '2020-11-01'
//       networkInterfaceConfigurations: [
//         {
//           name: 'string'
//           properties: {
//             deleteOption: 'string'
//             disableTcpStateTracking: bool
//             dnsSettings: {
//               dnsServers: [
//                 'string'
//               ]
//             }
//             dscpConfiguration: {
//               id: 'string'
//             }
//             enableAcceleratedNetworking: bool
//             enableFpga: bool
//             enableIPForwarding: bool
//             ipConfigurations: [
//               {
//                 name: 'string'
//                 properties: {
//                   applicationGatewayBackendAddressPools: [
//                     {
//                       id: 'string'
//                     }
//                   ]
//                   applicationSecurityGroups: [
//                     {
//                       id: 'string'
//                     }
//                   ]
//                   loadBalancerBackendAddressPools: [
//                     {
//                       id: 'string'
//                     }
//                   ]
//                   primary: bool
//                   privateIPAddressVersion: 'string'
//                   publicIPAddressConfiguration: {
//                     name: 'string'
//                     properties: {
//                       deleteOption: 'string'
//                       dnsSettings: {
//                         domainNameLabel: 'string'
//                       }
//                       idleTimeoutInMinutes: int
//                       ipTags: [
//                         {
//                           ipTagType: 'string'
//                           tag: 'string'
//                         }
//                       ]
//                       publicIPAddressVersion: 'string'
//                       publicIPAllocationMethod: 'string'
//                       publicIPPrefix: {
//                         id: 'string'
//                       }
//                     }
//                     sku: {
//                       name: 'string'
//                       tier: 'string'
//                     }
//                   }
//                   subnet: {
//                     id: 'string'
//                   }
//                 }
//               }
//             ]
//             networkSecurityGroup: {
//               id: 'string'
//             }
//             primary: bool
//           }
//         }
//       ]
//       networkInterfaces: [
//         {
//           id: 'string'
//           properties: {
//             deleteOption: 'string'
//             primary: bool
//           }
//         }
//       ]
//     }
//     osProfile: {
//       adminPassword: 'string'
//       adminUsername: 'string'
//       allowExtensionOperations: bool
//       computerName: 'string'
//       customData: 'string'
//       linuxConfiguration: {
//         disablePasswordAuthentication: bool
//         enableVMAgentPlatformUpdates: bool
//         patchSettings: {
//           assessmentMode: 'string'
//           automaticByPlatformSettings: {
//             bypassPlatformSafetyChecksOnUserSchedule: bool
//             rebootSetting: 'string'
//           }
//           patchMode: 'string'
//         }
//         provisionVMAgent: bool
//         ssh: {
//           publicKeys: [
//             {
//               keyData: 'string'
//               path: 'string'
//             }
//           ]
//         }
//       }
//       requireGuestProvisionSignal: bool
//       secrets: [
//         {
//           sourceVault: {
//             id: 'string'
//           }
//           vaultCertificates: [
//             {
//               certificateStore: 'string'
//               certificateUrl: 'string'
//             }
//           ]
//         }
//       ]
//       windowsConfiguration: {
//         additionalUnattendContent: [
//           {
//             componentName: 'Microsoft-Windows-Shell-Setup'
//             content: 'string'
//             passName: 'OobeSystem'
//             settingName: 'string'
//           }
//         ]
//         enableAutomaticUpdates: bool
//         enableVMAgentPlatformUpdates: bool
//         patchSettings: {
//           assessmentMode: 'string'
//           automaticByPlatformSettings: {
//             bypassPlatformSafetyChecksOnUserSchedule: bool
//             rebootSetting: 'string'
//           }
//           enableHotpatching: bool
//           patchMode: 'string'
//         }
//         provisionVMAgent: bool
//         timeZone: 'string'
//         winRM: {
//           listeners: [
//             {
//               certificateUrl: 'string'
//               protocol: 'string'
//             }
//           ]
//         }
//       }
//     }
//     platformFaultDomain: int
//     priority: 'string'
//     proximityPlacementGroup: {
//       id: 'string'
//     }
//     scheduledEventsProfile: {
//       osImageNotificationProfile: {
//         enable: bool
//         notBeforeTimeout: 'string'
//       }
//       terminateNotificationProfile: {
//         enable: bool
//         notBeforeTimeout: 'string'
//       }
//     }
//     securityProfile: {
//       encryptionAtHost: bool
//       securityType: 'string'
//       uefiSettings: {
//         secureBootEnabled: bool
//         vTpmEnabled: bool
//       }
//     }
//     storageProfile: {
//       dataDisks: [
//         {
//           caching: 'string'
//           createOption: 'string'
//           deleteOption: 'string'
//           detachOption: 'ForceDetach'
//           diskSizeGB: int
//           image: {
//             uri: 'string'
//           }
//           lun: int
//           managedDisk: {
//             diskEncryptionSet: {
//               id: 'string'
//             }
//             id: 'string'
//             securityProfile: {
//               diskEncryptionSet: {
//                 id: 'string'
//               }
//               securityEncryptionType: 'string'
//             }
//             storageAccountType: 'string'
//           }
//           name: 'string'
//           toBeDetached: bool
//           vhd: {
//             uri: 'string'
//           }
//           writeAcceleratorEnabled: bool
//         }
//       ]
//       diskControllerType: 'string'
//       imageReference: {
//         communityGalleryImageId: 'string'
//         id: 'string'
//         offer: 'string'
//         publisher: 'string'
//         sharedGalleryImageId: 'string'
//         sku: 'string'
//         version: 'string'
//       }
//       osDisk: {
//         caching: 'string'
//         createOption: 'string'
//         deleteOption: 'string'
//         diffDiskSettings: {
//           option: 'Local'
//           placement: 'string'
//         }
//         diskSizeGB: int
//         encryptionSettings: {
//           diskEncryptionKey: {
//             secretUrl: 'string'
//             sourceVault: {
//               id: 'string'
//             }
//           }
//           enabled: bool
//           keyEncryptionKey: {
//             keyUrl: 'string'
//             sourceVault: {
//               id: 'string'
//             }
//           }
//         }
//         image: {
//           uri: 'string'
//         }
//         managedDisk: {
//           diskEncryptionSet: {
//             id: 'string'
//           }
//           id: 'string'
//           securityProfile: {
//             diskEncryptionSet: {
//               id: 'string'
//             }
//             securityEncryptionType: 'string'
//           }
//           storageAccountType: 'string'
//         }
//         name: 'string'
//         osType: 'string'
//         vhd: {
//           uri: 'string'
//         }
//         writeAcceleratorEnabled: bool
//       }
//     }
//     userData: 'string'
//     virtualMachineScaleSet: {
//       id: 'string'
//     }
//   }
//   zones: [
//     'string'
//   ]
// }
