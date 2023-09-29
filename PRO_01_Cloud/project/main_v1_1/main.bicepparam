using './main.bicep'

// Location for the deployment
param location = 'uksouth'

// StorageAccount related params
param storageAccountSkuName = 'Standard_LRS'
param blobContainerName = 'postdeploymentscripts'

// WebServer related params
param webServerNamePrefix = 'webSever'
param webserverVnetName = 'web-app-vnet'
param webserverVnetAddressPrefix = '10.10.10.0/24'
param subnetVmssAdressPrefix = '10.10.10.0/25'
param subnetAppGwAdressPrefix = '10.10.10.128/28'
param webServerAdminLogin = 'webAdamDriver'
param webServerKey = getSecret('42d4abc3-eb16-4e20-997a-2a4e28016d24', 'testOmgevingncjez67xuemde', 'kv-i4nl4xnt2pckg', 'webGet12345')
// param webSslCertificateName = 'importWebCert'

// ManagementServer related params
param managementServerName = 'managementWin22'
param managementServerNamePrefix = 'managementServer'
param managementerverVnetName = 'management-vnet'
param managementserverVnetAddressPrefix = '10.10.20.0/24'
param subnetManagementAdressPrefix = '10.10.20.0/29'
param managementserverTrustedIp = 'ADD IP HERE'
param managementServerAdminLogin = 'mngmentAdamDriver'
param managementServerAdminLoginPassword = getSecret('42d4abc3-eb16-4e20-997a-2a4e28016d24', 'testOmgevingncjez67xuemde', 'kv-i4nl4xnt2pckg', 'mngmntGet12345')

// Permissions for accessing keyvault data
param webServerKeysPermissions = ['get', 'list', 'backup'] 
param webServerSecretPermissions = ['get', 'list', 'backup']
param webServerCertificatesPermissions = ['get', 'list', 'backup']

// Permissions for accessing keyvault data 
param managementServerKeysPermissions = ['all']
param managementServerSecretPermissions = ['all']
param managementServerCertificatesPermissions = ['all']


