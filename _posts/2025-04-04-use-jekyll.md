---
layout: post
title: Use and install Jekyll
date: 2025-04-04 17:31 -0400
description: Documentation guide for Jekyll.
author: philippe
categories: [Guide]
tags: [guide, tool]
image: 
    path: /assets/img/banners/jekyll.png
    alt: Documentation with Jekyll
---

To create a static website for our documentation, I used Jekyll, built with Ruby and RubyGems.

## Jekyll Chirpy

- The Jekyll theme is [jekyll-theme-chirpy](https://github.com/cotes2020/jekyll-theme-chirpy){: target="_blank" }
- This site was built using the following template: [chirpy-starter](https://github.com/cotes2020/chirpy-starter){: target="_blank" }
- You'll find documentation and examples for using and developing with this theme here: [Jekyll Chirpy Examples](https://chirpy.cotes.page/){: target="_blank" }

See the [theme documentation](https://github.com/cotes2020/jekyll-theme-chirpy/wiki).

## Install Ruby and Jekyll

To install Runby and RubyGems, you can follow the installation guide for your platform: [Jekyll - Installation](https://jekyllrb.com/docs/installation/){: target="_blank" }

For Windows:

1. Download [RubyInstaller Ruby+Devkit](https://rubyinstaller.org/downloads/){: target="_blank" }
1. Run the installer and install Ruby
1. In the last step, run `ridk install`  
    ![ruby install 1](/assets/img/installation/ruby/install1.png){: w="500" style="border-radius: 10px;" .shadow}
1. Install the `MSYS2 and MINGW development toolchain` option  
    ![ruby install 2](/assets/img/installation/ruby/install2.png){: w="500" style="border-radius: 10px;" .shadow}
1. Close the terminal once **successfully** completed  
    ![ruby install 3](/assets/img/installation/ruby/install3.png){: w="500" style="border-radius: 10px;" .shadow}
1. Open a new terminal and verify the installation:

    ```shell
    ruby -v
    gem -v
    ```

    > The installed tools should return the installed version.
    {: .prompt-info }
1. Open a new terminal and run this command to install Jekyll and Bundler

    ```shell
    gem install jekyll bundler
    ```

    > Once the installation is complete, you'll be ready to launch Jekyll on your computer.
    {: .prompt-info }
