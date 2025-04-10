---
layout: post
title: Install Git
date: 2025-04-04 13:45 -0400
description: Installation guide for Git.
author: philippe
categories: [Software]
tags: [guide, install]
image: 
    path: /assets/img/banners/git.png
    alt: Install Git
---

<!-- markdownlint-disable MD033 -->
## Installation

1. Download Git for your computer. [Télécharger Git](https://git-scm.com/downloads){: target="_blank" }

<iframe src="https://git-scm.com/downloads" width="100%" height="900px" style="border-radius: 10px; border: none; overflow: hidden;"></iframe>

1. Install Git with the downloaded installer. **Administrator rights are not required**.
1. You can change the configuration during installation if needed.
1. Perform the initial configuration below

## Configuration

1. Open a terminal
1. Configure your Git name and email

```shell
git config --global user.name "Your Name"
git config --global user.email "youremail@yourdomain.com"
```

## Vérification

Open your terminal and enter this command:

```shell
git --version
```

> Git should return the installed version.  
![verification](/assets/img/installation/git/verification.png){: w="200" style="border-radius: 10px;" .w-75 .normal .shadow }
{: .prompt-info }
