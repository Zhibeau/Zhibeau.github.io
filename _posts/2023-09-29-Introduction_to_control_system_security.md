---
title: Introduction to control system security
author: Zhibeau
date: 2023-09-29 14:07:00 -0400
img_path: https:////raw.githubusercontent.com/Zhibeau/zhibeau.github.io/main/_posts/9_29/
categories: [Cyber-Physical System,Cybersecurity, Notes]
tags: [Industrial control system]
---
ISA/IEC 62443 industrial security framework
Taxanomies

## What is control system cybersecurity?
- **Electronic security**: actions required toprotect critical systems or informational assetsfrom unauthorized use, denial of servicemodifications, disclosure, loss of revenue, destruction SOURCE:ISA/IEC 62443-1-1-2007
- **Control system**: hardware and software components ofan Industrial Automation andControl System (IACS) SOURCE:ISA/IEC 62443-2-4-2018
- **Cybersecurity**: measures taken to protect acomputer or computer system against unauthorized access or attack SOURCE:ISA/IEC 62443-3-2-2020

## Trends in control system cybersecurity?
- Increased Internet Protocols expose control systems
- Increased commercial off the shelf (equipment you can go and buy, plug and play. Issues: configuration not clear, supply chain attack)
- Increased remote monitoring andaccess
- Increased malicious codeattacks
- Increased unauthorized attempts
- Increased automated attack tools

## Implications
1. COTS components, increased connectivity and common protocols => Potential adversaries are familiar with the technology & Common risks.
2. Remote access => Broadens systems "attack surface"
3. Network separation can be difficult or impossible

## Potential consequences
**Data**: Disclosure, Alteration, Denial
**Physical**: Physical damage, Personnel injury
**Legal**: Vioulation of legal and regulatory requirements

## Key take-away from national cybersecurity reports
1. [National Security Agency (United States)](https://media.defense.gov/2021/Apr/29/2002630479/-1/-1/1/CSA_STOP-MCA-AGAINST-OT_UOO13672321.PDF): Look at your value vs. risk vs. cost for IT to OT connectivity. 
2. [European Union Agency for Cybersecurity](https://www.enisa.europa.eu/publications/enisa-threat-landscape-2022): Threat landscape
3. [Cybersecurity and Infrastructure Security Agency (United States)](https://www.cisa.gov/news-events/cybersecurity-advisories/aa20-049a): Encourage asset owner to review the contents of the alert for the threat actor techniques and ensure the mitigations + Commodity ransomware (Ransomware as a Service).
4. [Canadian Centre for Cyber Security (Canada)](https://www.cyber.gc.ca/en/guidance/national-cyber-threat-assessment-2023-2024#a4): 5 cyber threat narratives that are considered the most dynamic and impactful.


## Malware events
1. [Stuxnet](https://www.cybersecurity-insiders.com/iran-says-israel-launched-stuxnet-2-0-cyber-attack/)
1. [Shamoon](https://www.zdnet.com/article/shamoons-data-wiping-malware-believed-to-be-the-work-of-iranian-hackers/)
1. [OS Agnostic](https://www.linux.com/news/linux-malware-rise-look-recent-threats/)

## Common myths regarding IACS security
### Myth #1 Control system are not connected to the Internet
**Fact**: We can use [SHODAN](https://www.shodan.io/) to search the internated connected services:
Sample of typical applications
BACnet- Building Automation
DNP3- Electric/Water
EtherNet/IP_ Common Industrial ProtocolM
odbus- Open source SCADA
Niagara Fox- Building automation
Niagara Fox with SSL- Building automation
Siemens S7- Ethernet S7 PLC

### Myth #2 The industrial control systems are behind a firewall
**Fact**: Firewalls are insufficient network boundary protection. According to Gartner, through 2023, 99% of firewall breaches will be caused by firewall misconfigurations, not firewall flaws.

### Myth #3 Hackers don't understand control systems
**Fact**: Hacking as a service has hit the mainstreamm. SCADA and process control systems are common topics in Devcon or Black Hat conferences. Here is a [list](https://www.cisa.gov/known-exploited-vulnerabilities-catalog) of known exploited vulnerabilities for control systems.

### Myth #4 Safety systems can protect the system
 **Fact**: The safety systems are based on micro-processor programmed on Windows PC, and are using Ehternet communications with open and insecure protocols (Modbus TCP, OCP, etc.). TRITON is a malware targeting the safety system of chemical plants.