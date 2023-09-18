# [Cloud migration solution]

Convert the existing architecture to the cloud and improve/automate their processes.
[Assignment](https://docs.google.com/document/d/1zMBi8T1C5p88gZhXgDjz_DWZkTDmaJCs/edit)

## Current Structure

![Current structure](../../../00_includes/PRO_01/customer_current_structure.jpg)

We got the following infrastructure:

- Subscription,
  - Key vault
  - Recovery Service
  - Storage account
    - blob storage
  - VN1
    - NSG
    - VM (Web server)
      - Two different availability zones
  - VN2
    - NSG
    - VM (Management server)
      - Two availability zones
  - Peering between VN1 & VN2

## Requirements v1.0

- KeyVault (WORKING)
  - KeyVault policies
    - system assigned applications

- Recovery Service (WORKING)
  - Daily back up from the web sever
  - Backups are stored for 7 days

- StorageAccount (WORKING)
  - Module blob storage (postDeploymentScripts)
    - managementserver script to install AzCli (Work in progress)
    - webserver script to set-up Apache (Working)

- Peering (WORKING)
  - vnet webserver to vnet managementserver

- Network (WORKING)
  - Vnet 'app-prd-vnet'
    - Public IP
    - Private IP (10.10.10.0/24)
  - Vnet 'management-prd-vnet'
    - Public IP
    - Private IP (10.20.20.0/24)

- Firewall (WORKING)
  - NSG that only allows certain IP addresses for SSH connections
  - NSG Rules module (Work in progress)

- Web Server (WORKING)
  - SSH connection only via management server
  - Public IP (or public IP via Management Server?)
  - Private IP (10.10.10.0/24), same for subnet
  - Ubuntu Server 22.04 LTS Gen 2
    - West europe only availability zone 1
    - Standard_B1ls
    - SSH login via management server (WORKS)
    - Standard SSD
    - Key management 'platform-managed key' (Work in progress, add in v1.1)
    - Enable system assigned managed identity for KeyVault
    - Enable backup (1 back up per day, keep back up for 7 days)
    - userData via scripts

- Management server (WORKING)
  - SSH via Public IP, only trusted locations
  - Public IP
  - Private IP (10.20.20.0/24), same for subnet
  - Ubuntu Server 22.04 LTS Gen 2
    - West europe only availability zone 2
    - Standard_B1ls
    - SSH login trusted location (Add admin's IP to trusted IP's)
    - Standard SSD
    - Key management 'platform-managed key' (Work in progress, add in v1.1)
    - Enable system assigned managed identity for KeyVault
    - userData via scripts

## Design choices

Resources:  

- Location 'UK South', this was the best option with low latency for multiple 'Availability zones'  
- Web server, 'Ubuntu 22.04 LTS' this requires very little compute power and is supported till 2032.  
- Management server, same as above.  
- Firewall, NSG with security rules, as a stateful firewall this is sufficient to control the SSH connections from trusted sources.
- KeyVault, use system assigned identities for applications, easy to manage what rights the servers got within the vault.  
- Recovery Service, it's managed by Azure, requires little set up and is secure, encrypted back up data with user manged keys.

Deployment:

- Powershell script using Azure Powershell, this will automate some tasks instead of manually inputs to the terminal  
- Pre-deployment bicep to create resources for the environment with a resource group and key vault  
- Setting up secrets for the servers via the powershell script  
- Setting up the environment via the powershell script  
- Main-deployment bicep to set up the rest of the resources  

Pricing Estimates:

|Resource|Price(Estimation)|
|---|---|
|Webserver (Ubunut 22.04 LTS, b1ls)|$4.99/month|
|Managementserver (Ubunut 22.04 LTS, b1ls)|$4.99/month|
|StorageAccount (Hot, 1gb storage)|$1.71/month|
|VnetPeering (Uk South <-> Uk South)|free|
|Recovery Service (Webserver)|$5.82/month|
|Key Vault| $0.03/month/10k operations|
|---|---|
|Total|$17.54/month|

