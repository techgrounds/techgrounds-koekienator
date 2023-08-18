# [First Bicep Template]

Creating my first Bicep file via the ms learn module: build first bicep template

## Assignment

Creating my first Bicep file via the ms learn module: build first bicep template

### Key-terms

seed value
string interpolation
ternary operator

### Used Sources

[MS Doc, Set up Bicep](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/install)
[MS Learn, First Bicep Template](https://learn.microsoft.com/en-gb/training/modules/build-first-bicep-template/)

## Results

### Setting up Powershell to deploy to the cloud

[MS Learn, Install Bicep tools](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/install)  

```Powershell
winget install -e --id Microsoft.Bicep
```

You need to add Bicep to PATH, default location `C:\Users\<USERNAME>\AppData\Local\Programs\`.
Now you can use Powershell in VS Code and launch bicep templates!

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

### Parameters and Variables

Parameters suit dynamic aspects that change in each deployment, such as unique resource names, deployment locations, pricing-related settings, and external credentials. Variables, however, are fitting when consistent values are used across deployments, offering reusability within the template. They're also handy for forming complex values through expressions and for resources that don't necessitate unique names.

- Parameters  
    Parameters in a template allow you to input external values when deploying. For manual deployments via Azure CLI or Azure PowerShell, users provide parameter values. These values can be organized in a parameter file. Automated processes, like deployment pipelines, can also supply parameter values.  

- Add a parameter
    `param appServiceAppName string`  
    **Param** tells Bicep that you define a parameter  
    **appServiceAppName** is the name of the parameter. (Clear and understandable names!)  
    **String** is the type of the parameter. (string, int, bool, array, object)  

- Provide default values  
    `param appServiceAppName string = 'koek-product-launch-1`  
    Optionally you can provide default value for a parameter. The person who's deploying the template can specify a value if they want, but if they don't, Bicep uses the default value.  

- Variables  
    Variables are defined within the template. They serve as containers for storing crucial data, accessible throughout the template without duplication.  
    `var appServicePlanName = 'toy-product-launch-plan'`  

### Expressions

While crafting templates, hard-coding values or requesting them as parameters might not always be ideal. Rather, the aim is to uncover values during template execution. For instance, it's likely that you'd want all template resources to be deployed within the same Azure region as the resource group's location. Alternatively, you might desire an automated approach to generate distinct resource names based on a specific corporate naming convention.  

In Bicep, expressions present a potent tool to manage a variety of intriguing scenarios. Let's explore some instances where expressions within a Bicep template come into play.  

- Resource Location  
    `param location string = resourceGroup().location`  
    We called a function here called `resourceGroup()` this gives access to information about the resource group the template is being deployed into. Here we used `.location` property. It's common to use this approach to deploy your resources into the same Azure region as the resource group.  

- Resource Name  
    `param storageAccountName string = uniqueString(resourceGroup().id)`  
    Many Azure resources need unique names, so far we got two resources in our template the requires unique names: Storage account and the App Service app. It can make it difficult making uniques every time you use a template. Bicep has a function for this `uniqueString()` this will generate a unique string. With in this function we put `resourceGroup().id` this will make every "seed value" unique but consistent across all deployments.  

    Every time you deploy the same resources, they'll go into the same resource group. The uniqueString() function will return the same value every time.  
    If you deploy into two different resource groups in the Azure subscription, the resourceGroup().id value will be different, because the resource group names will be different. The uniqueString() function will give different values for each set of resources.  
    If you deploy into two different Azure subscriptions, even if you use the same resource group name, the resourceGroup().id value will be different because the Azure subscription ID will be different. The uniqueString() function will again give different values for each set of resources.  

- Combined strings  
    `param storageAccountName string = 'koek${uniqueString(resourceGroup().id)}'`
    We got `koek` as the string name, then add `${uniqueString(resourceGroup().id)}` for the random string generation.

### Selecting SKU for resources  

When you got multiple working environments you might want to set different SKU for those environments.

- Production Environment:  
    Storage accounts use Standard_GRS for resilience.  
    App Service plans use P2v3 for high performance.  

- Non-production Environment:  
    Storage accounts use Standard_LRS for local redundancy.  
    App Service plans use free F1 tier.  

Implementing these rules involves choices about embedding business logic directly in the template. You can achieve this by leveraging parameters, variables and expressions. We first introduce parameters, then variable determining the SKU's.

```Bicep
@allowed([
  'nonprod'
  'prod'
])
param environmentType string
```

```Bicep
var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'
var appServicePlanSkuName = (environmentType == 'prod') ? 'P2V3' : 'F1'
```

The logic is as following:
`storageAccountSkuName` follows the logic: If the environment is production, use Standard_GRS; otherwise, use Standard_LRS.  
`appServicePlanSkuName` uses P2V3 for production or F1 for non-production  

- `(environmentType == 'prod')` is a boolean, true or false
- `? option1 | option2` is an IF statement

### Launching our new template

We added all the parameters to the Bicep file.

```Bicep
@description('Specifies the location for resources.')
param location string = 'westeurope'

@description('Specifies name for the following resources with unique IDs.')
param storageAccountName  string = 'koek${uniqueString(resourceGroup().id)}'
param appServiceAppName string = 'koek${uniqueString(resourceGroup().id)}'

@description('Automatically set the SKUs for each environment type.')
@allowed([
  'nonprod'
  'prod'
])
param environmentType string

@description('Specifies name for the following resources with non-unique IDs.')
var appServicePlanName = 'koek-product-launch-plan-starter'

@description('Define the environment and set the SLU per environment')
var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'
var appServicePlanSkuName = (environmentType == 'prod') ? 'P2v3' : 'F1'
```

This might take a few minutes to launch and update in the portal.

```Bicep
New-AzResourceGroupDeployment -TemplateFile .\PRO_01_Cloud\ms_learn_bicep_module\02_main.bicep -environmentType nonprod
```

![CLI deployment](../../00_includes/PRO_01/first_launch_bicep_cli.jpg)
![Portal update](../../00_includes/PRO_01/check_launch_correct_4.jpg)

## Encountered problems

At the start had a few PATH not found errors for Bicep, kept finding installing guides on google but not what the default install path is. Eventually found it `C:\Users\<USERNAME>\AppData\Local\Programs\` there was a Bicep folder.  
