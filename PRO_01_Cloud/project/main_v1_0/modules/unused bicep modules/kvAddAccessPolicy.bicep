@description('Specifies the permissions to keys in the vault. Valid values are: all, encrypt, decrypt, wrapKey, unwrapKey, sign, verify, get, list, create, update, import, delete, backup, restore, recover, and purge.')
param keysPermissions array 

@description('Specifies the permissions to secrets in the vault. Valid values are: all, get, list, set, delete, backup, restore, recover, and purge.')
param secretsPermissions array 

@description('Specifies the permissions to certificates in the vault. Valid values are: all, get, list ,update, create, import, delete, recover, backup, restore, purge')
param certificatesPermissions array 

@description('The Keyvault Name you want to create this access policy for')
param kvName string

@description('The Virtual Machine Name you want to create this access policy for')
param vmName string

@description('The type of policy you want to make, add | remove | replace. Add is default')
@allowed([
  'add'
  'remove'
  'replace'
])
param policyType string = 'add'

resource kv 'Microsoft.KeyVault/vaults@2023-02-01' existing = {
  name: kvName
}

resource vm 'Microsoft.ScVmm/virtualMachines@2022-05-21-preview' existing = {
  name: vmName
}

resource kvAccessPolicy 'Microsoft.KeyVault/vaults/accessPolicies@2023-02-01' = {
  name: policyType
  parent: kv
  properties: {
    accessPolicies: [
      {
        applicationId: vm.identity.principalId
        objectId: vm.identity.principalId
        permissions: {
          certificates: certificatesPermissions
          keys: keysPermissions
          secrets: secretsPermissions
        }
        tenantId: vm.identity.tenantId
      }
    ]
  }
}
