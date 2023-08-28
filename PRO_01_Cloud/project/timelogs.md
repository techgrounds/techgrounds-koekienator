# Time logs

## Log [21/08/23]

### Daily report

Read the product owners requirements, think of questions to ask product owner.

### Obstacles

New way of thinking about the cloud I didn't learn yet with AZ900.
A lot of googling and checking in the portal what requirements there are to launch a resource.

### Solutions

Drawing word webs with potential requirements for resources.
Put the user stories in chronological order in Jira.

### Learnings

Basics of Jira.
Went over some requirements again to stat up a service/resource.

---

## Log [22/08/23]

### Daily report

Started on the bicep modules from microsoft training.  

### Obstacles

Bicep it self seems relatively easy.  
Was struggling with the sandbox environments sometimes.  

### Solutions

Found a work around for the not working sandboxes.  
Start one in an other module and then you can start it again in the module you're on.  
Better option than waiting X hours for reset.  

### Learnings

Basics of Bicep

---

## Log [23/08/23]

### Daily report

Meeting with product owner

### Obstacles

n/a

### Solutions

n/a

### Learnings

Virtual Machines got an option to select an availability zone.

---

## Log [24/08/23]

### Daily report

Created network.bicep and searched online for all requirements

### Obstacles

A fair amount of errors not to be found online (within 30mins)

### Solutions

Experiment, worked out ok-ish.
Deploying a second time sometimes changes the errors.

### Learnings

Error messages aren't always clear at first.
Deploying a second time sometimes changes the errors.

---

## Log [25/08/23]

### Daily report

Modulated network.bicep and added modules for the network elements in main.bicep

### Obstacles

Kept getting errors I couldn't find on the MS pages or StackOverflow

### Solutions

Auto fill requirements for a module in main.bicep.
This put all params in the correct order, therefore solving all errors I had.

### Learnings

Need to pay more attention to logic behind deploying aspects

---

## Log [28/08/23]

### Daily report

working on the VM implementation

### Obstacles

Keep getting errors about "Code:CanceledAndSupersededDueToAnotherOperation".
Can't say these error codes are very easy to read and understand, no easy to find online.

```json
{
    "status": "Failed",
    "error": {
        "code": "DeploymentFailed",
        "target": "/subscriptions/subid/resourceGroups/somerandombiceptesting/providers/Microsoft.Resources/deployments/webserver-fa6lzneoxbfsk",
        "message": "At least one resource deployment operation failed. Please list deployment operations for details. Please see https://aka.ms/arm-deployment-operations for usage details.",
        "details": [
            {
                "code": "ResourceDeploymentFailure",
                "target": "/subscriptions/subid/resourceGroups/somerandombiceptesting/providers/Microsoft.Network/networkSecurityGroups/webServerSubnet-NSG",
                "message": "The resource write operation failed to complete successfully, because it reached terminal provisioning state 'Canceled'.",
                "details": [
                    {
                        "code": "Canceled",
                        "message": "Operation was canceled.",
                        "details": [
                            {
                                "code": "CanceledAndSupersededDueToAnotherOperation",
                                "message": "Operation PutNetworkSecurityGroupOperation (98533895-7ac8-4058-a28c-31e907eb4199) was canceled and superseded by operation PutNetworkSecurityGroupOperation (13d11a84-0058-46d1-89c4-a79500dcbcc1)."
                            }
                        ]
                    }
                ]
            }
        ]
    }
}
```

### Solutions

This post on github, https://github.com/Azure/bicep/discussions/9791 helped me a fair bit.
Narrowed it down to just a NSG error instead 4 different network errors.
Did not have to define the NSG as it was already connected to the subnet.

### Learnings

Need to pay more attention to logic behind deploying aspects

---