# PhilBeaufort Doc

Hébergé ici : [link](http://docs.beaufort.dev)

[![Gem Version](https://img.shields.io/gem/v/jekyll-theme-chirpy)][gem]&nbsp;
[![GitHub license](https://img.shields.io/github/license/cotes2020/chirpy-starter.svg?color=blue)][mit]

## Requis

- Ruby et Jekyll [Installer Ruby/Jekyll](https://docs.beaufort.dev/posts/use-jekyll/)

## Développement local

1. Installer les dépendances gem : `gem install jekyll bundler`
1. Installer les dépendances jekyll : `bundle install`
1. Lancer le serveur de développement `bundle exec jekyll s`
1. Le serveur sera lancé à cette adresse : [http://127.0.0.1:4000/](http://127.0.0.1:4000/)

## Ajouter des articles

- Les articles du site Jekyll se trouve dans le dossier `_posts`
- Les auteurs pour les articles sont configurés dans le dossier `_data/authors.yaml`
- Les images sont dans le dossier `assets/img`

Vous pouvez créer un modèle pour un nouvel article avec cette commande :

```shell
bundle exec jekyll post "Nom article"
```

> Les dépendances doivent être installés

## Utilisation Jekyll Chirpy

- Le thème Jekyll est [jekyll-theme-chirpy][chirpy]
- Ce site a été construit depuis le modèle suivant : [chirpy-starter](https://github.com/cotes2020/chirpy-starter)
- Vous trouverez ici des exemples afin d'utiliser et de développer avec ce thème : [Exemples Jekyll chirpy](https://chirpy.cotes.page/)

Consultez la [documentation du thème](https://github.com/cotes2020/jekyll-theme-chirpy/wiki).

## Contribution

Ce dépôt est automatiquement mis à jour avec les nouvelles versions du dépôt de thèmes. Si vous rencontrez des problèmes ou souhaitez contribuer à son amélioration, veuillez consulter le [dépôt de thèmes][chirpy] pour nous faire part de vos commentaires.

## License

Ce travail est publié sous licence [MIT][mit].

[gem]: https://rubygems.org/gems/jekyll-theme-chirpy
[chirpy]: https://github.com/cotes2020/jekyll-theme-chirpy/
[mit]: https://github.com/cotes2020/chirpy-starter/blob/master/LICENSE
