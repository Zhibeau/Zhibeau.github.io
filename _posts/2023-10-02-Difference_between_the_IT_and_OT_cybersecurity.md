---
title: Difference between the IT and OT cybersecurity
author: Zhibeau
date: 2023-10-02 15:47:00 -0400
img_path: https:////raw.githubusercontent.com/Zhibeau/zhibeau.github.io/main/_posts/10_02/
categories: [Cyber-Physical System,Cybersecurity, Notes]
tags: [Industrial control system]
---

## What is difference between IT and IACS/OT?

## Strategic aspect
1. The security of IACS/OT has to address the issues of health, safety and environment
2. The priorities of the IT and OT are generally inversed:

![OTIT](OTIT.png)

3. Performance requirements:

| IT                                  | OT                                  |
|-------------------------------------|-------------------------------------|
| Response must be reliable           | Response is time critical           |
| High throughput                     | Modest throughput                   |
| High delay and jitter tolerated     | High delay is a serious concern     |
| Less critical emergency interaction | Response to emergencies is critical |
| IT protocols                        | IT and industrial protocols         |

4. Availability requirements:

| IT                                          | OT                                                         |
|---------------------------------------------|------------------------------------------------------------|
| Scheduled operation                         | Continuous operation                                       |
| Occasional failures tolerated               | Outages intolerable                                        |
| Rebooting tolerated                         | Rebooting may not be acceptable                            |
| Beta testing in the field acceptable        | Thorough QA testing expected in non-production environment |
| Modifications possible withlittle paperwork | Formal certification may be required after any change      |

5. Operating environments:

| IT                                                                           | OT                                                                    |
|------------------------------------------------------------------------------|-----------------------------------------------------------------------|
| Typical “Office” Applications                                                | Special Applications                                                  |
| Standard OS                                                                  | Standard and embedded OS                                              |
| Upgrades arestraightforward                                                  | Upgrades are challenging and may impact hardware, logics and graphics |
| Technology is refreshed often Commercial Off The Shelf (COTS) (3 to 5 years) | Legacy systems (15-20 years)                                          |
| Abundant resources(memory, bandwidth)                                        | Resource constrained                                                  |
| Data center, server room oroffice environment                                | Industrial environment                                                |

6. Risk management requirements:

| IT                                                      | OT                                                          |
|---------------------------------------------------------|-------------------------------------------------------------|
| Data confidentiality and integrity are paramount        | HSE and production are paramount (integrity & availability) |
| Risk impact is loss of datadelay of business operations | Risk Impact is loss of life.equipment or product            |
| Recover by reboot                                       | Fault tolerance essential                                   |

## Tactic aspect
### Network segmentation
*OT more isolated, but with remote I/O system*
**IT**: IT systems are usually composed of interconnected subnets =>   Primary focus: access controls and protection from the Internet =>  sophisticated firewalls, proxy servers, intrusion detection/prevention devices, etc. 
Security between subnets is typically limited.
**OT**: No access to the Internet or to email should be allowed from ICS networks. ICS networks should be rigorously defended from other plant networks, especially those with Internet access.

### Network topology
**IT**: 1. Large (contain data centers, intranets, and Wi-Fi networks) dynamic => use many automated tools, such as dynamic host configuration protocol (DHCP), to manage their network topologies. 2. Each object contains an access control list that identifies who has been granted/denied access to the object.
**OT**: 1. small and static => DHCP and Wi-Fi segments are discouraged. 2. The ICS is partitioned into three levels (0, 1, and 2): Level 0 represents the physical process; Level 1 is control and monitoring; and Level 2 is supervisory control.

### User accounts
**IT**: IT system administrators often administer operating system user accounts with Windows Domains/Active Directory.
**OT**: Although in principle this is similar to IT application security, the complexity, scope, and technical expertise required to administer ICS users is closely related to the nature of the process being controlled, which is generally not familiar to IT system administrators

### Safety instrumented systems (SIS)
**IT**: No systems analogous to the SIS.
**OT**: Commonly used IT tools and network devices are not applicable to SIS network security.