---
title: Introduction to common services
author: Zhibeau
date: 2023-09-17 16:51:00 -0400
img_path: https:////raw.githubusercontent.com/Zhibeau/zhibeau.github.io/main/_posts/9_17/
categories: [Pentest,Cybersecurity]
tags: [Port scan, services]
---

In the pentest, the service enumeration is essential for getting the first step on the target host. Every service offered by the destination has a specific purpose and can be utilized by us. As a result, we need to understand how the services work. This article will review the function of common services and how can them be used in a pentest.

## File Transfer Protocol (FTP)
*Upload or downlowad files*
**TCP PORT 21 (FTP control)**: The client sends commands to the server, and the server returns status codes.
**TCP PORT 20 (FTP data transfer)**: The client sends commands to the server, and the server returns status codes.
**Dangerous settings**: Anonymous operations
**Exploitability**: File upload or download credential information
**Things to learn**: FTP commands

## Server Message Block (SMB)
*Regulates access to files and entire directories and other network resources such as printers, routers, or interfaces released for the network.*
**TCP PORT 137,138,139**: Used by the Samba SMB server
**TCP PORT 445**: Used by CIFS (a very specific implementation of the SMB protocol for communicating with newer Windows systems)
**Dangerous settings**: listing available shares, priviledges, automated script excecution
### Tools
*Enumerate all domains, available shares, domain users*
**rpcclient**, **Impacket - Samrdump.py**, **SMBmap**, **CrackMapExec**, **Enum4Linux-ng**

## Network File System (NFS)
*access file systems over a network as if they were local (between Linux and Unix systems)*
**TCP and UDP ports 2049 (NFSv4)**
**TCP and UDP ports 111**:NFS is based on the Open Network Computing Remote Procedure Call (ONC-RPC/SUN-RPC) for *authentication* or *authorization*.
**Dangerous settings**: Permissions
**Exploitability**: Retrive credential information
**Things to learn**: Show Available NFS Shares ```Show Available NFS Shares``` and how to mount an NFS share
**Tips**: The files can be invisible (e.g., /.ssh)

## Domain Name System (DNS)
*translate domain names into IP addresses*
### DNS records
| DNS Record | Record information                                                                                     |
|------------|--------------------------------------------------------------------------------------------------------|
| A          | IPv4 address                                                                                           |
| AAAA       | IPv6 address                                                                                           |
| MX         | Responsible mail servers                                                                               |
| NS         | DNS servers (nameservers) of the domain                                                                |
| TXT        | Various text information                                                                               |
| CNAME      | Used when another domain is pointed to the same IP                                                     |
| PTR        | IP addresses => valid domain names.                                                                    |
| SOA        | Provides information about the corresponding DNS zone and email address of the administrative contact. |