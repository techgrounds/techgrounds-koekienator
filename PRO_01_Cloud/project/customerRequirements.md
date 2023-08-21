# [Cloud migration solution]

Convert the existing architecture to the cloud and improve/automate their processes.
![Assignment](https://docs.google.com/document/d/1zMBi8T1C5p88gZhXgDjz_DWZkTDmaJCs/edit)

## Current Structure

![Current structure](../00_includes/PRO_01/customer_current_structure.jpg)

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

## Requirements

Virtual Machines:
    - Distribution: ?
    - Allowed regions: ?
    - VM Size: ?
    - Type of authentication: ?
    - Disk type: ?
    - Encrypted Disk: Yes

Virtual Network:
    - IP ranges: 10.10.10.0/24 & 10.20.20.0/24
    - Two VN or One with subnets?
    - Peering: Yes

Web-server:
    - Distribution: ?
    - Daily backup: Yes
    - Daily Backup storage: 7 days
    - Automatically installed: Yes
    - SSH or RDP: ? , only via management server

Management-server:
    - Distribution: ?
    - Daily backup: ?
    - Daily backup storage: ?
    - Reachable Public IP: Yes
    - Only via trusted locations: Yes
    - SSH or RDP: ?

Storage-Account:
    - 