######################################################################################################
######################################################################################################
##                                                                                                  ##
##      Start with 'New-AzSubscriptionDeployment -whatif -templatefile predeployment.bicep'         ##
##  This will create an unique resourceGroup name, you can change the 'rgPrefix' to your likings    ##
##      Now you can set the unique name can past it in this script                                  ##
##                                                                                                  ##
######################################################################################################

# This function generates a random password
function Get-RandomPassword {
    param (
        [int]$length = 32
    )

    $characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()_+-=[]{}|;:,.<>?'
    $password = ''

    for ($i = 0; $i -lt $length; $i++) {
        $password += $characters[(Get-Random -Minimum 0 -Maximum $characters.Length)]
    }

    return $password
}

function Start-Stopwatch {
    $stopwatch = [System.Diagnostics.Stopwatch]::new()
    $stopwatch.Start()

    return $stopwatch
}

function Stop-Stopwatch {
    param (
        [System.Diagnostics.Stopwatch]$stopwatch
    )

    $stopwatch.Stop()
    $elapsed = $stopwatch.Elapsed
    $formattedTime = "{0:D2}m {1:D2}s {2:D3}ms" -f $elapsed.Minutes, $elapsed.Seconds, $elapsed.Milliseconds

    return $formattedTime
}

try {

    ##################
    ## Start script ##
    ##################

    Write-Host "Post-deployment script started"

    # Set the deployment location
    $location = 'uksouth'

    # Define secret names and generate random passwords
    $secretName1 = 'webAdmin1234'
    # $secretName1 = Read-Host 'Enter the secretname, must start with a letter'
    $randomPassword1 = Get-RandomPassword
    $secretValue1 = ConvertTo-SecureString $randomPassword1 -AsPlainText -Force

    $secretName2 = 'mngmntAdmin1234'
    # $secretName2 = Read-Host 'Enter the secretname, must start with a letter'
    $randomPassword2 = Get-RandomPassword
    $secretValue2 = ConvertTo-SecureString $randomPassword2 -AsPlainText -Force
    
    ##############################
    ## Start the pre-deployment ##
    ##############################
    
    # Deploy the pre-deployment deployment
    $sw1 = Start-Stopwatch
    Write-Host "started deploying 'predeployment.bicep'"
    $preDeployment = New-AzSubscriptionDeployment -templatefile .\predeployment.bicep -Location $location -OutVariable out
    $elapsedTime1 = Stop-Stopwatch -stopwatch $sw1
    Write-Host "finished deploying 'predeployment.bicep in $($elapsedTime1)'"

    # Set the new resource group and key vault from the outputs
    $resourceGroup = $preDeployment.Outputs["getResourceGroupName"].Value
    $keyVault = $preDeployment.Outputs["getKeyVaultName"].Value

    #Set the newRG as default resource group for deployments
    $setNewRGSet = Set-AzDefault -ResourceGroupName $resourceGroup
    Write-Host "Succesfully created the resource group $($resourceGroup) and set it as default"

    # Create the new secrets for the keyvault
    $setSecret1 = Set-AzKeyVaultSecret -VaultName $keyVault -Name $secretName1 -SecretValue $secretvalue1 
    $setSecret2 = Set-AzKeyVaultSecret -VaultName $keyVault -Name $secretName2 -SecretValue $secretvalue2 
    Write-Host "Succesfully created keyvault $($keyVault) and posted the secrets"

    ###############################
    ## start the main deployment ##
    ###############################

    $sw2 = Start-Stopwatch 
    Write-Host "started deploying 'main.bicep'"
    $mainDeployment = new-azresourcegroupdeployment -TemplateFile .\main.bicep -TemplateParameterFile .\main.bicepparam -mode incremental
    $elapsedTime2 = Stop-Stopwatch -stopwatch $sw2

    # Get the hostname and ssh connection details from the deployment outputs
    $hostName = $mainDeployment.outputs["webSite"].value
    $ssh1 = $mainDeployment.outputs["sshManagementServer"].value
    $ssh2 = $mainDeployment.outputs["sshWebServer"].value
    Write-Host "Go to the webServers webpage: $($hostName)"
    Write-Host "Connect to mngmntServer: $($ssh1)"
    Write-Host "Connect to webServer: $($ssh2)"
    Write-Host "finished deploying 'main.bicep' in $($elapsedTime2)"
}
catch {
    Write-Host "An error occurred: $($_.Exception.Message)"
}

