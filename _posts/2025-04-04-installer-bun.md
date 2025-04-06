---
layout: post
title: Installer Bun
date: 2025-04-04 13:11 -0400
description: Guide d'instalation pour Bun.
author: philippe
categories: [Logiciels]
tags: [installation]
image: 
    path: https://icon.icepanel.io/Technology/svg/Bun.svg
    alt: Installation Bun
---

Bun est un nouveau environnement d’exécution JavaScript entièrement développé pour répondre aux besoins de l’écosystème JavaScript moderne. Il poursuit trois objectifs de conception majeurs, dont la rapidité. Bun démarre et s’exécute rapidement. Il étend JavaScriptCore, le moteur JavaScript performant conçu pour Safari. Des temps de démarrage rapides sont synonymes d’applications et d’API rapides.

<!-- markdownlint-disable MD033 -->
## Installation

1. Naviguer vers ce site : [https://bun.sh](https://bun.sh){: target="_blank" }
1. Copier la commande d'installation pour votre ordinateur.

<iframe src="https://bun.sh" width="770px" height="850px" style="border-radius: 8px; border: none; overflow: hidden;"></iframe>

1. Lancer la commande
    - Avec `powershell` pour Windows
    - Avec `bash` pour Linux & macOS

## Vérification

Ouvrir votre terminal et entrer cette commande :

```shell
bun --version
# ou
bun -v

```

> Bun devrait retourner la version installée
![vérification](/assets/img/installation/bun/verification.png){: w="200" style="border-radius: 10px;" .w-75 .normal .shadow }
{: .prompt-info }

## Justification

J'ai décidé de migrer le webhook de traduction CX à Bun - Hono afin de réduire le temps de Cold Start lorsque Google Cloud Run doit démarrer une instance et j'ai aussi migrer le service à typescript pour améliorer la maintenabilité.

![startup_latency](/assets/img/installation/bun/startup_latency.png){: w="400" style="border-radius: 10px;" .shadow}
_Graphique de latence au démarrage du service_

- Les points d'exclamation sont des déploiements, quand les changements ont été faits le 2 et 3 avril 2025.
![environnement](/assets/img/installation/bun/environment_setup.png){: w="400" style="border-radius: 10px;" .shadow .right}
- Lors de la première phase de déploiement, j'ai changé l'environnement utilisé pour réduire les temps de démarrage  
- L'amélioration n'était pas majeure, c'est pourquoi j'ai cherché d'autres solutions. Puisque **Bun** est compatible avec tous les projets **Node.js,** j'ai essayé de faire la migration. L'amélioration était bonne, mais il y avait des problèmes, la maintenabilité et la lisibilité du projet n'étaient pas les meilleures.
- C'est pourquoi j'ai migré à **Hono** avec **Bun** et **TypeScript** qui permettrait d'ajouter de la sécurité de type. Dans la deuxième phase de déploiement, après la migration, j'ai déployé le projet directement en TypeScript et le temps de démarrage avait augmenté. C'est pourquoi j'ai dû compiler le projet avec `tsc` en JavaScript et tout était parfait.
