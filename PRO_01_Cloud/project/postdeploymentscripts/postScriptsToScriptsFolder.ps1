# Variables
$resourceGroupName = "koekbiceptestomgeving"
$storageAccountName = "scriptsfa6lzneoxbfsk"
$containerName = "postdeploymentscripts"
$sourceFolderPath = ".\postdeploymentscripts"  # Path to the folder containing scripts

# Authenticate
az login

# Upload scripts to Blob Container
Get-ChildItem -Path $sourceFolderPath -Recurse | ForEach-Object {
    $blobName = $_.FullName.Substring($sourceFolderPath.Length).TrimStart("\")
    $blobPath = "$containerName/$blobName"
    az storage blob upload --account-name $storageAccountName --account-key (az storage account keys list -g $resourceGroupName -n $storageAccountName --query '[0].value' -o tsv) --container-name $containerName --name $blobPath --type block --source $_.FullName
}