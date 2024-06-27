---
title: Supply Chain Security - Github Action
author: Zhibeau
date: 2024-06-26 20:09:00 -0400
img_path: https:////raw.githubusercontent.com/Zhibeau/zhibeau.github.io/main/_posts/24_06_26/
categories: [Cybersecurity, DevOps]
tags: [Supply Chain Security, DevOps]
---

# MontréHack June 2024 Meetup

In the June 2024 meetup event of MontréHack, the host [François Proulx](https://www.linkedin.com/in/francoisp/) gave an introductive presentation about supply chain security. He also created an examplar CTF [Github repository](https://github.com/fproulx-boostsecurity/gravy-overflow/tree/main) for us to get our hands dirty in the supply chain security. The following parts of this post will show the command injection vulnerability in the CTF.

# Basics of the Supply Chain Security

Supply chain security involves safeguarding the entire process of producing and delivering goods, from sourcing raw materials to delivering the final product to consumers. This infographic highlights various threats that can compromise the integrity of a supply chain, categorized into source threats, dependency threats, and build threats. Source threats include unauthorized changes (A), compromised source repositories (B), and building from modified sources (C). Dependency threats involve the use of compromised dependencies (D). Build threats encompass compromising the build process (E), uploading modified packages (F), compromising the package registry (G), and using compromised packages (H).

In the CTF, we delved into the threat E. This vulnerability is presented in GitHub Actions.

![supply-chain-threats.svg](supply-chain-threats.svg)

# Github Action - Workflow

The `.yml` file configures the workflow for GitHub Actions workflow. This workflow is triggered by specific events related to issues, issue comments, and pull requests. Here's a breakdown of how this workflow is structured:

```yml
name: Poutine Level 0
on:
  issues:
    types: [opened, edited]
  issue_comment:
    types: [created, edited]
  pull_request_target:
    types: [opened, synchronize]
    branches:
      - main
  pull_request:
    types: [closed]
    branches:
      - main

permissions: {}

concurrency:
  group: ${{ github.workflow }}
  cancel-in-progress: false
```

- **Workflow Triggers (`on`)**:
  
  - **issues**: Triggered when an issue is opened or edited.
  - **issue_comment**: Triggered when an issue comment is created or edited.
  - **pull_request_target**: Triggered when a pull request targeting the `main` branch is opened or synchronized.
  - **pull_request**: Triggered when a pull request targeting the `main` branch is closed.

- **Permissions**: Specifies permissions for the workflow. In this case, no additional permissions are set globally (`permissions: {}`).

- **Concurrency**: Ensures that only one instance of the workflow runs at a time for a given group, which is set to the workflow name.

- **Jobs**: The workflow defines four jobs, each with specific conditions and steps:
  
  ```yml
  jobs:
    fries:
      runs-on: ubuntu-latest
      timeout-minutes: 1
      if: github.event_name == 'issues'
      permissions:
        id-token: write
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        FLAG_GRAVY_OVERFLOW_L0_FRIES: ${{ secrets.FLAG_GRAVY_OVERFLOW_L0_FRIES }}
      steps:
        - uses: step-security/harden-runner@63c24ba6bd7ba022e95695ff85de572c04a18142 # v2.7.0
          with:
            egress-policy: audit
        - uses: rlespinasse/github-slug-action@v4
          with:
            short-length: 8
        - name: Check for profanities in issue body
          id: check_profanities
          run: |
            echo "Checking issue body for profanities..."
            PROFANITIES_LIST="bad|disguting|horrible"
            if echo "${{ github.event.issue.body }}" | grep -qiE "$PROFANITIES_LIST"; then
              echo "Profanity detected in issue body. Please clean up the language."
              exit 1
            else
              echo "No profanities found in issue body."
              exit 0
            fi
  ```
  
  **fries**:
  
  - **Runs-on**: `ubuntu-latest`
  - **Timeout**: 1 minute
  - **Condition**: Runs only if the event is an issue event.
  - **Permissions**: Allows writing to the ID token.
  - **Environment Variables**: Uses `GITHUB_TOKEN` and a secret for a flag.
  - **Steps**:
    - Uses the `step-security/harden-runner` action for auditing egress policy.
    - Uses the `rlespinasse/github-slug-action` to generate a short slug.
    - Runs a script to check for profanities in the issue body.

# Command injection in jobs

 In the `script` part of the job `fries`, we can see the body of the issue is inserted in the bash code: `if echo "${{ github.event.issue.body }}"`, so, we can inject our payload in the body of the issue to exfiltrate sensitive information in `env`: `${{ secrets.GITHUB_TOKEN }}`

To trigger the build process, we need to create or edit an issue, the payload `" | (echo $GITHUB_TOKEN | base64); then ls #` should be included in the body of the issue. The information is encoded in base64 because if the Actions will protect the sensitive env (it will be `***` if it is not encoded![fries_injection.png](fries_injection.png)

  After edited the issue, the action is running, we can check the output in the `Actions` tab:

  ![fries_exfiltration.png](fries_exfiltration.png)

  After decoding, the token in plain text can be seen:

```bash
root@aaa:~# echo "Z2hzXzduSzBEZjFWdmZuUTZQcWhPTDVoVmVwRExNR0pYNDE2T2NTbwo=" | base64 -d
```