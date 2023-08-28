# [Errors I've encountered]

## InvalidTemplate/TemplateViolation

### Reason

No idea why I get this as the other server running from the same bicep file doesn't get this error.

### The error in Json

```json
{
    "status": "Failed",
    "error": {
        "code": "DeploymentFailed",
        "target": "/subscriptions/42d4abc3-eb16-4e20-997a-2a4e28016d24/resourceGroups/koekbiceptestomgeving/providers/Microsoft.Resources/deployments/managementserver-fa6lzneoxbfsk",
        "message": "At least one resource deployment operation failed. Please list deployment operations for details. Please see https://aka.ms/arm-deployment-operations for usage details.",
        "details": [
            {
                "code": "InvalidTemplate",
                "message": "Unable to process template language expressions for resource '/subscriptions/42d4abc3-eb16-4e20-997a-2a4e28016d24/resourceGroups/koekbiceptestomgeving/providers/Microsoft.Network/networkInterfaces/managementserver-fa6lzneoxbfskNetInt' at line '1' and column '2890'. 'Unable to evaluate template language function 'resourceId': function requires exactly one multi-segmented argument which must be resource type including resource provider namespace. Current function arguments 'Microsoft.Network/virtualNetworks/subnets,management-prd-vnet,10.20.20.0/25'. Please see https://aka.ms/arm-resource-functions/#resourceid for usage details.'",
                "additionalInfo": [
                    {
                        "type": "TemplateViolation",
                        "info": {
                            "lineNumber": 1,
                            "linePosition": 2890,
                            "path": ""
                        }
                    }
                ]
            }
        ]
    }
}
```

### How did I solve it

Was staring at this error so long I just couldn't see it.
Did a spelling check with chatGPT, it saw I put a wrong param somewhere at the management server VM.
Should have seen that the address suffix shouldn't be there!

`'Microsoft.Network/virtualNetworks/subnets,management-prd-vnet,10.20.20.0/25'`

## 

