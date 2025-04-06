---
layout: post
title: Installer Google Cloud CLI
date: 2025-04-04 13:45 -0400
description: Guide d'instalation pour Google Cloud CLI.
author: philippe
categories: [Logiciels]
tags: [installation]
image: 
    path: https://www.svgrepo.com/show/353805/google-cloud.svg
    alt: Installation Google Cloud CLI
---

Afin de développer localement avec les outils de Google Cloud, on utilise `Google Cloud CLI (gcloud)`. Il est nécessaire de l'installer et de le configurer afin de permettre un accès local sécurisé aux API de Google depuis des librairies.

## Google Cloud CLI

1. Télécharger et installer Google Cloud CLI (gcloud) : [Installer gcloud CLI](https://cloud.google.com/sdk/docs/install?hl=fr){: target="_blank" }
    ***L'option d'installation pour un seul utilisateur n'a pas besoin de droit d'administrateur.***
    ![installation 1](/assets/img/installation/gcloud/installation_1.png){: w="400" style="border-radius: 10px;" .w-75 .normal .shadow }
{: .prompt-tip }

1. À la fin de l'installation, assurez-vous de sélectionner l'option `Run 'gcloud init' to config...`
    ![installation 2](/assets/img/installation/gcloud/installation_2.png){: w="400" style="border-radius: 10px;" .w-75 .normal .shadow }

1. Un terminal sera ouvert pour exécuter la commande : `gcloud init`
    - Connexion à votre compte Google
    - Sélectionner le projet auquel vous voulez travailler
    - **Ne pas** choisir une `default compute Region and Zone`

> Une fois cette configuration complétée, vous pourrez utiliser `Google Cloud CLI (gcloud)` afin de gérer les ressources de Google
{: .prompt-info }
> [Aide mémoire CLI gcloud](https://cloud.google.com/sdk/docs/cheatsheet?hl=fr){: target="_blank" }
{: .prompt-tip }

## Clé de développement local

Une clé d'authentification est nécessaire afin d'utilisé Google Cloud SDK, librairies (Python, Node.js, etc.), et API. Afin de créer une clé d'authentification avec vos accès, utiliser cette commande dans le terminal :

```shell
gcloud auth application-default login
```

> Une clé d'authentification locale sera créée avec:
>
> - les accès Google accordés à votre compte.
> - un accès aux API activés de votre projet GCP.
{: .prompt-info }
> Pour plus d'information, vous pouvez consulter la documentation de Google : [ICI](https://cloud.google.com/docs/authentication/provide-credentials-adc?hl=fr#how-to){: target="_blank" }
{: .prompt-tip }
