---
title: Web Fuzzing
author: Zhibeau
date: 2024-01-26 12:55:00 -0400
img_path: https:////raw.githubusercontent.com/Zhibeau/zhibeau.github.io/main/_posts/24_01_26/
categories: [Notes]
tags: [Web, Pentest]
---

## 1. Web Fuzzing in one sentence

Similar to password bruteforcing, it envolves sending crafted http request to test the if the guessed structure of the website is ture.

## 2. What to fuzz

### 2.1 Directory & Page

To guess valied strings (Directory, ):

```http://SERVER.PORT/FUZZ_Dir/.../FUZZ_Page.FUZZ_extension
http://SERVER:PORT/FUZZ_Dir/.../FUZZ_Page.FUZZ_extension
```

- FUZZ_Dir: Directory fuzzing

- FUZZ_Page: Page fuzzing

- FUZZ_extension: Page extension fuzzing

**Recursive** : specify the depth of subdirectories. E.g., http://SERVER.PORT/FUZZ_Dir1/FUZZ_Dir2

### 2.2. Sub-domain / Vhost

**Vhost**: short for "virtual host," is a concept used in web server configuration that allows a single web server to host multiple websites or domain names.

1. **Name-based virtual hosting**: This is the <u>most common type</u> of virtual hosting. In name-based virtual hosting, <u>multiple domain names are served from a single IP address.</u> The web server <u>relies on the `Host` header field in the HTTP request to determine which website to serve.</u> This is an efficient way to host multiple websites on a single server without the need for multiple IP addresses.

2. **IP-based virtual hosting**: In this configuration, each website hosted on the server has its own unique IP address, even though they may share the same physical server. This setup is less common due to the scarcity of available IP addresses but can be useful in specific scenarios, such as when SSL/TLS certificates were tied to IP addresses rather than domain names.

```
http://FUZZ_Subdomain.SERVER:PORT/
```

- For Normal sub-domain: Direct fuzzing FUZZ_Subdomain

- For vhost : Use -H to specify the host name

```shell
ffuf -w wordlist.txt:FUZZ -u http://academy.htb:PORT/ -H 'Host: FUZZ.academy.htb' -fs xxx
```

### 2.3. Parameter

- GET

```shell
ffuf -w wordlist.txt:FUZZ -u http://admin.academy.htb:PORT/admin/admin.php?FUZZ=key -fs xxx	
```

- POST

```shell
ffuf -w wordlist.txt:FUZZ -u http://admin.academy.htb:PORT/admin/admin.php -X POST -d 'FUZZ=key' -H 'Content-Type: application/x-www-form-urlencoded' -fs xxx
```

- Parameter value

```shell
ffuf -w ids.txt:FUZZ -u http://admin.academy.htb:PORT/admin/admin.php -X POST -d 'id=FUZZ' -H 'Content-Type: application/x-www-form-urlencoded'
```

Tips: It is allowed to use multiple ```-H```. E.g., Fuzz Vhost subdomain & Parameter with POST method

```shell
ffuf -w wordlist.txt:FUZZ -u http://academy.htb:PORT/admin/admin.php -X POST -d 'FUZZ=key' -H 'Host: Subdomain.academy.htb' -H 'Content-Type: application/x-www-form-urlencoded' -fs xxx
```

### 2.4 Filtering Results

With a long wordlist, most web request with invalid words will get the same response. As a result, we need to find the common points of these invalid attemps and filter them. Then we can get the valid fuzzing results.