# [Cloud migration solution]

Convert the existing architecture to the cloud and improve/automate their processes.
![Assignment](https://docs.google.com/document/d/1zMBi8T1C5p88gZhXgDjz_DWZkTDmaJCs/edit)

## Current Structure

![Current structure](../../00_includes/PRO_01/customer_current_structure.jpg)

We got the following infrastructure:

- Subscription,
  - Key vault
  - Recovery Service
  - Storage account
    - blob storage
  - VN1
    - NSG
    - VM (Web server)
      - Two availability zones
  - VN2
    - NSG
    - VM (Management server)
      - Two availability zones
  - Peering between VN1 & VN2

## Requirements v1.0

- RBAC, can't set this up with RBAC

- KeyVault (WORKING)
  - KeyVault policies
    - system assigned applications

- Recovery Service (WORKING)

- StorageAccount (WORKING)
  - Module blob storage (postDeploymentScripts)
    - script install dependencies (W.I.P.)
    - script set-up Apache (W.I.P.)
    - script backup (Using recovery service instead)

- Peering (WORKING)
  - vnet webserver, vnet managementserver

- Network (WORKING)
  - Vnet 'app-prd-vnet'
    - Public IP 
    - Private IP (10.10.10.0/24)
      - NSG (port )
      - Subnet IP
  - Vnet 'management-prd-vnet'
    - Public IP
    - Private IP (10.20.20.0/24)
      - Subnet IP

- Web Server (Low cost, SSH req.)(WORKING)
  - SSH connection only via management server
  - Public IP (or public IP via Management Server?)
    - Private IP (10.10.10.0/24), same for subnet
    - Ubuntu Server 20.04 LTS Gen 1 (~$4.40 west europe)(~$4.30 uk south)
      - West europe only availability zone 2, UK South 1/2/3
      - Standard_B1ls
      - SSH login via management server (WORKS)
      - Inbound port only 22 (WORKS)
      - Standard SSD
      - Key management 'platform-managed key' (NEED TO WORK THIS OUT, KV?)
      - Enable system assigned managed identity for KeyVault
      - Enable backup (must read options to clarify what tier for 7 day back up storage)
      - Custom data and cloud init (? maybe instead of backup, we run a back up script?)

- Management server (Low cost, SSH req.)(WORKING)
  - Access via Public IP, trusted location
  - Public IP
  - Private IP (10.20.20.0/24), same for subnet
  - Ubuntu Server 20.04 LTS Gen 1 (~$4.40 west europe)(~$4.30 uk south)
    - West europe only availability zone 2, UK South 1/2/3
    - Standard_B1ls
    - SSH login via management server
      - Save KeyPair in KeyVault, only access via management server?
    - Inbound port only 22 (TRUSTED LOCATIONS ONLY)
    - Standard SSD
    - Key management 'platform-managed key' (NEED TO WORK THIS OUT, KV?)
    - userData via scripts

## requirements v1.1
