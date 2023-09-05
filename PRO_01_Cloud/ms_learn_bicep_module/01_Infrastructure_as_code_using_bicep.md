# [Bicep]

*Azure Bicep is a language and tool that aims to improve the experience of defining, deploying, and managing Azure resources. It offers a more human-friendly syntax, simplifies the creation of ARM templates, promotes code reusability, and aligns with the concept of Infrastructure as Code.*  

## Key-terms

- ***IoC:*** Infrastructure as Code
- ***Imperative Syntax:*** Step-by-step instructions that need to be followed in a specific order.  
- ***Declarative syntax:*** Instead of step-by-step, you describe the end goal without specifying the exact process to achieve it.  
- ***Transpilation*** is the process of converting source code written in one language into another language.

## Used Sources

[MS Doc, Bicep](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/overview?tabs=bicep)  
[MS Learn module, Introduction to infrastructure as code using Bicep](https://learn.microsoft.com/en-gb/training/modules/introduction-to-infrastructure-as-code-using-bicep/)  
[Youtube, Getting Started with Azure Bicep](https://www.youtube.com/watch?v=77AfsFzTsI4)  

## Introduction to Bicep

### Infrastructure as code

**Infrastructure as Code (IoC)** is a method of automating the setup and management of infrastructure using code. It replaces manual configuration processes with code that defines and provisions resources like virtual networks, virtual machines, applications, and storage. This code-based approach ensures consistent and repeatable deployments.  

- **Advantages of Using IoC:**
    - **Confidence Boost:** IoC enhances deployment confidence by ensuring consistency and security.
    - **Process Integration:** IoC smoothly integrates with existing processes, ensuring consistency.
    - **Automated Security Scanning:** IoC automates security scanning for enhanced security.
    - **Efficient Secret Management:** IoC helps manage sensitive information efficiently.
    - **Access Control:** IoC contributes to better access control.
    - **Preventing Configuration Drift:** IoC prevents configuration drift by automating deployments.

- **Application Environments in Organizations:**
    Organizations manage various application environments like development, testing, and production. IoC helps in creating new environments, managing non-production stages, and implementing disaster recovery strategies.

- **Enhanced Cloud Resource Insight:**
    IoC improves understanding of cloud resources' status, aids in audit trails, ensures thorough documentation, and promotes a unified approach to system administration.

- **Imperative and Declarative Code:**
    IoC can be achieved using imperative or declarative code. Imperative code provides step-by-step instructions, while declarative code only defines the desired end state.

- **Azure Resource Manager (ARM):**
    ARM is a platform for deploying and managing resources in Azure. It offers features like access control, auditing, and tagging for effective resource management.

- **ARM Templates:**
    ARM templates define resource deployment using JSON or Bicep. They ensure consistent, repeatable outcomes and integrate with CI/CD pipelines.

- **Bicep:**
    Bicep is a domain-specific language for creating ARM templates. It offers a simplified syntax, modularity, automated dependency management, and better tooling.

- **How Bicep Works:**
    Bicep templates are transpiled to JSON for deployment. Azure CLI and PowerShell support Bicep. Resource Manager processes Bicep templates, orchestrating resource creation based on the intended state.

- **Choosing Bicep:**
    Bicep is advantageous for Azure-focused deployments due to its native integration, support, and seamless transition from JSON. Consider existing tools and multicloud environments before adopting Bicep.

In summary, Infrastructure as Code automates infrastructure management through code, offering benefits like consistency, security, and efficiency. Azure Resource Manager and Bicep are tools that facilitate IoC in Azure, streamlining resource provisioning and management. Bicep provides a simplified syntax and Azure-native advantages for template creation and deployment.