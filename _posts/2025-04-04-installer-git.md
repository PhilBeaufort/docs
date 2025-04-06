---
layout: post
title: Installer Git
date: 2025-04-04 13:45 -0400
description: Guide d'instalation pour Git.
author: philippe
categories: [Logiciels]
tags: [installation]
image: 
    path: /assets/img/logo/git.png
    alt: Installation Git
---

<!-- markdownlint-disable MD033 -->
## Installation

1. Télécharger Git pour votre ordinateur. [Télécharger Git](https://git-scm.com/downloads){: target="_blank" }

<iframe src="https://git-scm.com/downloads" width="100%" height="900px" style="border-radius: 10px; border: none; overflow: hidden;"></iframe>

1. Installer Git avec l'installateur téléchargé. **Les droits d'administrateur ne sont pas nécessaires**.
1. Vous pouvez changer la configuration lors de l'installation au besoin.
1. Effectuer la configuration initiale ci-dessous

## Configuration

1. Ouvrir un terminal
1. Configurer votre nom et courriel git

```shell
git config --global user.name "Your Name"
git config --global user.email "youremail@yourdomain.com"
```

## Vérification

Ouvrir votre terminal et entrer cette commande :

```shell
git --version
```

> Git devrait retourner la version installée.  
![verification](/assets/img/installation/git/verification.png){: w="200" style="border-radius: 10px;" .w-75 .normal .shadow }
{: .prompt-info }
