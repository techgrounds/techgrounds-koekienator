# [Azure Core Services]

```text
WORK IN PROGRESS
```

What are some core services used frequently in Azure?

## Assignment

- Study the AZ900 exam guide.

### Key-terms

### Used Sources

https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE3VwUY  

## Results

### Core Services Azure

#### Regions and Region Pairs

Geographical area on the planet.  
One but usually more datacenters connected with low-latency network (<2 MS).  
Location for your services.  
Some services are available only in certain regions.  
Some services are global services.  
Globally 50+ regions.  
Special Government regions.  
Special partnered regions.  

Each region is paired with another region making it a region pair.  
Region pairs are static and cannot be chosen.  
Each pair resides within the same geography.  
Physical isolation with at least 483km distance.  
Some services have platform-provided replication.  
Planned updates across the pairs.  
Data residency maintained for disaster recovery.

#### Availability Zones

Grouping of physically separated facilities.  
Designed to protect from datacenter failure.  
If a zone goes down others continue working.  
Zonal services (VM, Disks, etc.)  
Zone-redundant services (SQL, Storage, etc.)  
Not all regions are supported.  
Supported regions has three of more zones.  
A zone is one or more datacenters.  

#### Resource Groups

#### subscriptions

#### Management Groups

#### Azure Resource Manager

#### Virtual Machines

#### Azure App Services

#### Azure Container Instances (ACI)

#### Azure Kubernetes Service (AKS)

#### Azure Virtual Desktop

#### Virtual Networks

#### VPN Gateway

#### Virtual Network Peering

#### ExpressRoute

#### Container (Blob) Storage

#### Disk Storage

#### File Storage

#### Storage Tiers

#### Cosmos DB

#### Azure SQL Database

#### Azure Database for MySQL

#### Azure Database for PostgreSQL

#### SQL Managed Instance

#### Azure Marketplace

## Encountered problems
