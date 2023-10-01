---
title: Introduction to control system security
author: Zhibeau
date: 2023-09-29 14:07:00 -0400
img_path: https:////raw.githubusercontent.com/Zhibeau/zhibeau.github.io/main/_posts/9_30/
categories: [Cyber-Physical System,Cybersecurity, Notes]
tags: [Industrial control system]
---

## What is Nessus?
Nessus is a platform developed by Tenable that scans for security vulnerabilities in devices, applications, operating systems, cloud services and other network resources. It is maintained by Tenable with free version - Nessus Essentials. Nessus Essentials has a limit to 16 IPs Addresses that can be used for vulnerability scans. This article will introduce how to do vulnerability scan with Nessus Essentials.

## Vulnerability scan with Nessus
Firstly, we need to download Nessus.

![1_Download](1_Download.png)

During downloading, we can sign up and apply for a license.

![2_Register](2_Register.png)

After downloading, we can install Nessus in the terminal.

![3_Install](3_Install.png)

After installing, a local register is needed.

![4_Register_local](4_Register_local.png)

Finally, we can create a new scan.

![5_Create_newscan](5_Create_newscan.png)

In the new scan, we need firstly set the IP address.

![6_set_ip](6_set_ip.png)

The scanned ports can be assigned. Here we choose to scall all ports.

![7_scan_all_ports](7_scan_all_ports.png)

The possible useful credential can be set for different authentification (SSL, windows, etc.)

![8_set_credentials](8_set_credentials.png)

After the scanning, we can read the report. We can searh keywords in the report. For example, "SMB share".

![9_SMB_Share](9_SMB_Share.png)

Vulnerabilities found are also listed.

![10_Vulnerabilities](10_Vulnerabilities.png)

We can also export the report in other forms, e.g., pdf for small size reports, csv for large size reports.

![11_Report_export](11_Report_export.png)
