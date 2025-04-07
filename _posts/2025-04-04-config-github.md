---
layout: post
title: Config Github
date: 2025-04-04 17:32 -0400
description: Guide and configuration for using the Github platform.
categories: [Guide]
tags: [guide, tool]
image: 
    path: /assets/img/logo/github.png
    alt: Doc Jekyll
---

## Config SSH

To use Git with GitHub, an SSH key must be created on your computer and added to your GitHub account settings.

1. Open the terminal
1. Create a new `SSH` key with this command

    ```shell
    ssh-keygen -t ed25519 -C "<user_mail>"
    ```

    - `<user_mail>` is your email address.

1. Open the new key `C:\Users\<username>\.ssh\id_ed25519.pub` in a **text editor**.
1. Add the key contents to a new `SSH` key on Github

Step|Image|Description
-|-|-
1|![github ssh 1](/assets/img/developpeur/github_ssh_1.png){: w="600" style="border-radius: 10px;" .shadow}| Click on the profit image
2|![github ssh 2](/assets/img/developpeur/github_ssh_2.png){: w="300" style="border-radius: 10px;" .shadow}| Open Github settings
3|![github ssh 3](/assets/img/developpeur/github_ssh_3.png){: w="300" style="border-radius: 10px;" .shadow}| Opening SSH and GPG Key Settings
4|![github ssh 4](/assets/img/developpeur/github_ssh_4.png){: w="500" style="border-radius: 10px;" .shadow}| New SSH Key
5|![github ssh 5](/assets/img/developpeur/github_ssh_5.png){: w="500" style="border-radius: 10px;" .shadow}| Configuring the New SSH Key

- Add a name to the key
- Copy the contents of the public key `id_ed25519.pub` into the `Key` field
- Finally, validate and add the key

> Once this configuration is complete, you will be able to use Github and Git to `clone`, `commit`, `push`, `pull`, etc.
{: .prompt-tip }
