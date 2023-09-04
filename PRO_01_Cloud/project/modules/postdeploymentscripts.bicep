resource uploadPostDeploymentScripts 'Microsoft.Resources/deployments@2022-09-01' = {
  name: 'uploadPostDeploymentScripts'
  properties: {
    mode: 'Incremental'
    templateLink: {

    }
  }
}
