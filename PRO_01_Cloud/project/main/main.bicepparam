using './main.bicep'

// Location for the deployment
param location = 'uksouth'
// StorageAccount related params
param storageAccountSkuName = 'Standard_LRS'
param containerPostDeploymentScripts = 'postdeploymentscripts'

// WebServer related params
param webServerNamePrefix = 'webSever'
param webServerVnetAddressPrefix = '10.10.10.0/24'
param webServerSubnetAddressPrefix = '10.10.10.0/24'
param webServerAdminLogin = 'webAdmin'
param webServerAdminLoginPassword = getSecret('42d4abc3-eb16-4e20-997a-2a4e28016d24', 'koekGrpncjez67xuemde', 'kv-cdsrclz6pcua6', 'webAdmin1234')

// ManagementServer related params
param managementServerNamePrefix = 'managementServer'
param managementServerVnetAddressPrefix = '10.20.20.0/24'
param managementServerSubnetAddressPrefix = '10.20.20.0/24'
param managementServerAdminLogin = 'mngmntAdmin'
param managementServerAdminLoginPassword = getSecret('42d4abc3-eb16-4e20-997a-2a4e28016d24', 'koekGroupncjez67xuemde', 'kv-cdsrclz6pcua6', 'mngmntAdmin1234')

// Permissions for accessing keyvault data
param webServerKeysPermissions = ['get', 'list', 'backup'] 
param webServerSecretPermissions = ['get', 'list', 'backup']
param webServerCertificatesPermissions = ['get', 'list', 'backup']

// Permissions for accessing keyvault data 
param managementServerKeysPermissions = ['all']
param managementServerSecretPermissions = ['all']
param managementServerCertificatesPermissions = ['all']


