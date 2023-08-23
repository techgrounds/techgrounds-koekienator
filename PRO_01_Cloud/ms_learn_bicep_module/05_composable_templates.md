# [Create composable Bicep files by using modules]

Design and build reusable modules to simplify your Bicep templates. Compose multiple modules into templates by using parameters and outputs.

- Design and create reusable, well-structured Bicep modules
- Create Bicep files that use multiple modules together

## Assignment

### Key-terms

Modules
Condition

### Used Sources

[MS training, Create composable Bicep files by using modules](https://learn.microsoft.com/en-us/training/modules/create-composable-bicep-files-using-modules/)

## Results

### **Creating and Using Bicep Modules Simplified:**

Modules in Bicep are like building blocks that group resources and can be reused in different templates. They make your code cleaner and more organized, providing several benefits.

#### **Benefits of Modules:**

- **Reusability:** Modules can be used in multiple templates, making it easy to share and reuse code.
- **Encapsulation:** Modules keep related resources together, making templates simpler and easier to manage.
- **Composability:** Modules can be combined to create complex deployments by passing information between them.

#### **Creating a Module:**

- A module is a separate Bicep file.
- Modules should group related resources, not individual ones.
- Create descriptive file names for your modules.

#### **Splitting Existing Templates into Modules:**

- Use the Bicep visualizer to help split large files into smaller modules.
- Modules help keep related resources together, even if they are defined in separate files.

#### **Nesting Modules:**

- Modules can include other modules, allowing you to create complex resource structures.
- Avoid excessive nesting for simplicity.

#### **Using Modules in Bicep Templates:**

- Use the `module` keyword to include a module in a template.
- Specify a symbolic name, module path, deployment name, and parameters for the module.
- JSON ARM templates can also be used as modules.

#### **How Modules Work:**

- Deployments in Azure represent deployment operations and can be created or updated using Bicep.
- Modules create separate deployments; one for the parent template and one for each module.
- Bicep converts modules into a single JSON ARM template when deployed.

In essence, Bicep modules help you organize resources, improve reusability, and simplify the process of creating and managing cloud deployments.

### **Adding Parameters and Outputs to Bicep Modules Simplified:**

When creating Bicep modules, consider them as contracts that define how resources are created and interacted with. They accept parameters, create resources, and provide outputs. Here's how to work with parameters and outputs in modules:

#### **Module Parameters:**

- Define what parameters the module needs to fulfill its purpose.
- Parameters can be optional or required.
- Default parameters are often better set in the parent template, not the module, to maintain clarity.

#### **Using Conditions:**

- You can use conditions to make modules adaptable to different scenarios.
- Example: Module deploys Azure Cosmos DB and conditions allow configuring Log Analytics workspace for logs.

#### **Module Outputs:**

- Modules can define outputs that the parent template might need.
- Use outputs for information that should be accessible in the parent template.
- Don't use outputs for secret values; use Azure Key Vault or other secure methods.

#### **Chaining Modules Together:**

- Modules can be combined in a parent Bicep file.
- Parent templates can use outputs from one module as inputs for another.
- Bicep automatically understands and deploys modules with dependencies.

In essence, parameters and outputs in Bicep modules help you create reusable and flexible code that adapts to different needs while maintaining clarity and organization.

## Encountered problems

n/a
