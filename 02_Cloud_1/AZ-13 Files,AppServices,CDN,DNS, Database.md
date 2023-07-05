# [Files,AppServices,CDN,DNS,Database]

Common services you will interact with on a regular base. 

## Assignment

Study:  

- App Services
- Content Delivery Network (CDN)
- Azure DNS
- Azure Files
- Azure Database

### Key-terms

- App Services
- Content Delivery Network (CDN)
- Azure DNS
- Azure Files
- Azure Database
- API, a set of definitions and protocols for building and integrating applications software. It can be seen as a mediator between the users or clients and the resources of a web service they want to get.
- REST API or RESTful API, are based on a client-server model, where the client is typically a web or mobile app that consumes data or services from a server. RESTful API are widely used for building webs services, web applications and mobile applications, as it is a flexible and scalable way to expose and consume data and services over the internet.
- Serverless (Functions as a Service or FaaS)

### Used Sources

[Redhat (REST)API](https://www.redhat.com/en/topics/api/what-is-a-rest-api)

## Results

### App Service (PaaS)

[MS Doc, App Services](https://learn.microsoft.com/en-us/azure/app-service/overview)
[MS Doc, AWS vs Azure App Service](https://learn.microsoft.com/en-us/azure/architecture/aws-professional/services)
[Youtube, Azure app services](https://www.youtube.com/watch?v=4BwyqmRTrx8)

App services enable you to build and host web apps, mobile back ends, and RESTful APIs in the programming language of your choice without managing the infrastructure (PaaS).  
It offers auto-scaling and high availability, supports both Windows and Linux, and enables automated deployments from GitHub, Azure DevOps, or any Git repo.  

- App service plan (defines a set of compute resources for a web app to run)
- Supports multiple languages: C#, PHP, Java, JavaScript (Node.js), Python, Ruby, Docker
- Optimized for DevOps: Azure DevOps, GitHub, BitBucket, Local Git, Docker Hub, etc..
- Global Scale with high availability, Guaranteed 99.5% availability for app service. Scale up (improve the VM, more ram/cpu) & Scale out options (increase amount of VMs).  
- Security and compliance:  
-- ISO, SOC (Security Operations Center, set of guidelines to ensure security, availability, confidentiality and process integrity of financial organizations) and PCI (Payment Card Industry, it secures your credit card and billing information) complaint  
-- Authentication features with Azure AD, Google, Facebook, Twitter, MS Live, etc..
- Visual Studio Integration (VSCode is the open source variant)
- API and mobile features including CORS and push notifications



#### Azure App service and on-premise resources

There are a few ways you can combine the App Service with on-prem resources.

- Hybrid Connectivity: This approach is suitable when you need to access on-prem databases, services, or other resources from your Azure hosted application.
- Hybrid Identity: This integration method allows users to authenticate against their on-prem domain and access Azure App service using single sign-on (SSO).
- Hybrid Data: This allows you to securely access on-prem databases or web services from your App Service without requiring any network configuration changes.
- Azure API management: This provides a unified and controlled access point to on-prem services and data
- Azure Logic Apps and Azure Functions: Allows you to trigger on-prem action or retrieve data and incorporate them into your App Service application.

#### Combine Azure App Service with other services

Azure App Service, falls under the whole branch of Azure Compute services.

Combine Azure App Service with Azure Functions and 

![Screenshot alternatives to App Service](../00_includes/AZ-01/Azure_APP_Service_alternatives.jpg)

#### What is the difference with Azure App Service and likewise solutions?

Azure App Service,  
Azure Spring Apps,  
Azure Service Fabric  


### CDN  

[MS Doc, Content Delivery Network](https://learn.microsoft.com/en-us/azure/cdn/cdn-overview?toc=%2Fazure%2Ffrontdoor%2FTOC.json)

### Azure DNS  

[MS Doc, Azure DNS](https://learn.microsoft.com/en-us/azure/dns/dns-overview)

### Azure Files  

[MS Doc, Azure Files](https://learn.microsoft.com/en-us/azure/storage/files/storage-files-introduction)

### Azure Database  

[MS Doc, Azure SQL](https://learn.microsoft.com/en-us/azure/azure-sql/azure-sql-iaas-vs-paas-what-is-overview?view=azuresql)

## Encountered problems  

