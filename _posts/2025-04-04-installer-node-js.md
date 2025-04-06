---
layout: post
title: Installer Node.js
date: 2025-04-04 13:45 -0400
description: Guide d'instalation pour Node.js.
author: philippe
categories: [Logiciels]
tags: [installation]
toc: true
image: 
    path: /assets/img/logo/nodejs.png
    alt: Installation Node.js
---

## Installation (sans accès admin)

1. Télécharger le binaire Node.js (.zip) [Télécharger Node.js®](https://nodejs.org/fr/download){: target="_blank" }  
    ![node installer bin](/assets/img/installation/node/node_installer_bin.png){: w="200" style="border-radius: 10px;" .shadow}  
1. Décompresser le contenu à l'emplacement de votre choix. Cet exemple sera fait dans le dossier `C:\Apps`.
1. Une fois décompresser un nouveau dossier sera dans le répertoire ex : `node-v22.14.0-win-x64`
1. Ouvrir l'utilitaire pour modifier les variables d'environnements por **votre compte**
1. Ajouter le chemin d'accès vers ce dossier dans la variable `Path`

    Variable | Chemin d'accès
    -|-
    Path | `C:\Apps\node-v22.14.0-win-x64`

## Installation (avec accès admin)

1. Télécharger l'installateur Node.js (.msi) [Télécharger Node.js®](https://nodejs.org/fr/download){: target="_blank" }  
    ![node installer msi](/assets/img/installation/node/node_installer_msi.png){: w="200" style="border-radius: 10px;" .shadow}  
1. Lancer l'installateur et suivre les instructions jusqu'à la fin de l'installation.

## Vérification

Ouvrir votre terminal et entrer ces commandes :

```shell
node -v
npm -v
```

>Node.js et npm devraient retourner la version installé.  
![verification](/assets/img/installation/node/verification.png){: w="200" style="border-radius: 10px;" .w-75 .normal .shadow }
{: .prompt-info }
