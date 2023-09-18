// @description('Resource group where the virtual machines are located. This can be different than resource group of the vault. ')
// param existingVirtualMachinesResourceGroup string 

@description('Array of Azure virtual machines. e.g. ["vm1","vm2","vm3"]')
param vmName string

@description('Name of the Recovery Services Vault')
param vaultName string

@description('Backup policy to be used to backup VMs. Backup POlicy defines the schedule of the backup and how long to retain backup copies. By default every vault comes with a \'DefaultPolicy\' which canbe used here.')
param policyName string = 'dailyVmBackup'

@description('Location for all resources.')
param location string 


var backupFabric = 'Azure'
var scheduleRunTimes = [
  '2017-01-26T05:30:00Z'
]
var v2VmType = 'Microsoft.Compute/virtualMachines'
var v2VmContainer = 'iaasvmcontainer;iaasvmcontainerv2;${resourceGroup().name}'
var v2Vm = 'vm;iaasvmcontainerv2;${resourceGroup().name}'

resource recoveryServicesVault 'Microsoft.RecoveryServices/vaults@2023-04-01' = {
  name: vaultName
  location: location
  sku: {
    name: 'RS0'
    tier: 'Standard'
  }
  properties: {
    publicNetworkAccess: 'Disabled'
  }
}

resource backupPolicy 'Microsoft.RecoveryServices/vaults/backupPolicies@2023-04-01' = {
  parent: recoveryServicesVault
  name: policyName
  location: location
  properties: {
    // policyType: 'V2'
    backupManagementType: 'AzureIaasVM'
    instantRpRetentionRangeInDays: 2
    schedulePolicy: {
      schedulePolicyType: 'SimpleSchedulePolicy'
      scheduleRunFrequency: 'Daily'
      scheduleRunTimes: scheduleRunTimes
    }
    retentionPolicy: {
      retentionPolicyType: 'LongTermRetentionPolicy'
      dailySchedule: {
        retentionTimes: scheduleRunTimes
        retentionDuration: {
          count: 7
          durationType: 'Days'
        }
      }
      // weeklySchedule: null
      // monthlySchedule: null
      // yearlySchedule: null
    }
    timeZone: 'Romance Standard Time'
  }
}

resource protectedItems 'Microsoft.RecoveryServices/vaults/backupFabrics/protectionContainers/protectedItems@2023-04-01' = {
  name: '${vaultName}/${backupFabric}/${v2VmContainer};${vmName}/${v2Vm};${vmName}'
  properties: {
    protectedItemType: v2VmType
    policyId: backupPolicy.id
    sourceResourceId: resourceId(subscription().subscriptionId, resourceGroup().name, 'Microsoft.Compute/virtualMachines', vmName)
  }
}
