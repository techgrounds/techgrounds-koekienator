# [First Bicep Template]

Creating my first Bicep file via the ms learn module: build first bicep template

## Assignment

Creating my first Bicep file via the ms learn module: build first bicep template

### Key-terms

[Schrijf hier een lijst met belangrijke termen met eventueel een korte uitleg.]

### Used Sources

[MS Learn, First Bicep Template](https://learn.microsoft.com/en-gb/training/modules/build-first-bicep-template/)

## Results

### Setting up Powershell to deploy to the cloud

[MS Learn, Install Bicep tools](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/install)  

```Powershell
winget install -e --id Microsoft.Bicep
```

You need to add Bicep to PATH, default location `C:\Users\<USERNAME>\AppData\Local\Programs\`.
Now you can use pwsh in VS Code and launch bicep templates!

### Sign in to Azure via Powershell

`Connect-AzAccount` gives a popup window (in VS Code at least), here you can log in to Azure.  

```Bash
$context = Get-AzSubscription -SubscriptionName 'Put your own subscription name here'
Set-AzContext $context
```

### Deploy your first bicep template

- Set the default resource group
    `Set-AzDefault -ResourceGroupName [Your resource group name here]`

- Deploy the template
    `New-AzResourceGroupDeployment -TemplateFile [path/to/template]`

- Verify your deployment via the portal (might take a few minutes before it shows).

    ![Step 1](../../00_includes/PRO_01/check_launch_correct_1.jpg)

    ![Step 2](../../00_includes/PRO_01/check_launch_correct_2.jpg)

    ![Step 3](../../00_includes/PRO_01/check_launch_correct_3.jpg)

- Verify your deployment via the CLI
    `Get-AzResourceGroupDeployment -ResourceGroupName [Your resource group name here] | Format-Table`

## Encountered problems

At the start had a few PATH not found errors for Bicep, kept finding installing guides on google but not what the default install path is. Eventually found it `C:\Users\<USERNAME>\AppData\Local\Programs\` there was a Bicep folder.  
