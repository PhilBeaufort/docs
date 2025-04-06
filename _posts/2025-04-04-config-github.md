---
layout: post
title: Configuration Github
date: 2025-04-04 17:32 -0400
description: Guide et configuration pour utiliser la plateforme Github.
categories: [Guide]
tags: [guide, outil]
image: 
    path: /assets/img/logo/github.png
    alt: Documentation avec Jekyll
---
## Configuration SSH

Afin d'utiliser Git avec GitHub, une clé SSH doit être créée sur votre poste et ajouter dans les paramètres de votre compte GitHub.

1. Ouvrir le terminal
1. Créer une nouvelle Clé `SSH` avec cette commade

    ```shell
    ssh-keygen -t ed25519 -C "<user_mail>"
    ```

    - `<user_mail>` est votre adresse courriel.

1. Ouvrir la nouvelle clé `C:\Users\<username>\.ssh\id_ed25519.pub` dans un **éditeur de texte**.
1. Ajouter le contenu de la clé dans une nouvelle clé `SSH` sur Github  

Étape|Image|Description
-|-|-
1|![github ssh 1](/assets/img/developpeur/github_ssh_1.png){: w="600" style="border-radius: 10px;" .shadow}| Clic sur image de profit
2|![github ssh 2](/assets/img/developpeur/github_ssh_2.png){: w="300" style="border-radius: 10px;" .shadow}| Overture des paramètres de Github
3|![github ssh 3](/assets/img/developpeur/github_ssh_3.png){: w="300" style="border-radius: 10px;" .shadow}| Overture des paramètre de clés SSH et GPG
4|![github ssh 4](/assets/img/developpeur/github_ssh_4.png){: w="500" style="border-radius: 10px;" .shadow}| Nouvelle clé SHH
5|![github ssh 5](/assets/img/developpeur/github_ssh_5.png){: w="500" style="border-radius: 10px;" .shadow}| Configuration de la nouvelle clé SSH

- Ajouter un nom à la clé
- Copier le contenu de la clé publique `id_ed25519.pub` dans le champ `Key`
- Finalement valider et ajouter la clé

> Une fois cette configuration faite, vous pourrez utiliser github et git pour `clone`, `commit`, `push`, `pull` , etc.
{: .prompt-tip }
