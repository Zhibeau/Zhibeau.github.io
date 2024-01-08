---
title: Tool | OSINT | linkedin2username
author: Zhibeau
date: 2023-01-07 22:51:00 -0400
img_path: https:////raw.githubusercontent.com/Zhibeau/zhibeau.github.io/main/_posts/24_01_07/
categories: [Cybersecurity, Pentest, Tool]
tags: [OSINT]
---

## linkedin2username in one sentence
Generate username lists from companies on LinkedIn.

## Implementation method
A web-scraper based on the selenium module in python

## Two use cases
We can start the linkedin2username with the following one-line command:
```python3 linkedin2username.py -c trojan -s 2```
where **-c** means the name of the company to search and **-s** means the sleep time between each search.
Then the default browser will open a LinkedIn log in page, we need to input the account that we will use to conduct the user search
![LogIn](1.png)
After loggin in, we press enter in the command console and wait for the searching process.
![Searching](2.png)
The generated username list will be output into files with different forms:
- first.last.txt: Usernames like Joe.Schmoe
- f.last.txt: Usernames like J.Schmoe
- flast.txt: Usernames like JSchmoe
- firstl.txt: Usernames like JoeS
- first.txt Usernames like Joe
- lastf.txt Usernames like SchmoeJ
- rawnames.txt: Full name like Joe Schmoe
- metadata.txt CSV file which is full_name,occupation

Here is what we got in **trojan.first.last.txt**:
![Result trojan](3.png)
As we can see in the output, there are only the user "linkedin.member", because we used a newly registered account. Since we haven't connect anyone, the users in the search results will be protected and shown as "LinkedIn Member" (depending on the privacy setting of the user).
![LinkedIn Member](5.png)
If we search for a larger company, for example, google, we can have some valid results (even though there are still a large amount of "LinkedIn Member").
![Result google](4.png)

## Conclusion
linkedin2username.py is a very easy-to-use tool which can save our time in crafting a username list targeting a certain company. However, there are some points we need to aware:
1. If we want to have more valid results, we need to connect some people in the target company. (The next version of the linkedin2username.py also need to deal with the issue of "linkedin member")
2. We may need to be security checked by linkedin if we run the tool too frequently.
3. We would better to use **-s** to not get our account locked.