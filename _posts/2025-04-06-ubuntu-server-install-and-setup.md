---
layout: post
title: Ubuntu Server Install and Setup
date: 2025-04-06 18:15 -0400
description: First Config of ubuntu server
categories: [Documentation, Server]
tags: [documentation, server, ubuntu]
image: 
    path: /assets/img/logo/ubuntu_server.png
    alt: Documentation avec Jekyll
---

<!-- markdownlint-disable MD007 -->
<!-- markdownlint-disable MD031 -->
## 🔧 Setup a boot and installation media (Autoinstall not working)

`parameters` represent my config

1. Download the most recent [Ubuntu server LTS](https://ubuntu.com/download/server)
1. Use [Rufus](https://rufus.ie/en/) and USB Key to create a Boot Media
1. Once the boot media is completed, open the USB with a file manager
1. Launch to Installation Media with the computer 1 time boot option
1. Choose language `English`
1. Keyboard `French (Canada)`, Variant `Canada (intl.)`, the objective is to have something similar to Canadian Multi.
1. Choose your installation `Ubuntu server`
1. Use an entire disk. If not available, go to [Clean Boot Drive.](#-clean-boot-drive-from-live-environment-before-install)
1. Profile config :

  - Your name `<complete_name>`
  - Server name `home-server`
  - User name `<user_name>`
  - password `<user_password>`

1. You can activate Ubuntu pro right now if you want by entering the code given if you choose to activate here : [https://ubuntu.com/pro/attach](https://ubuntu.com/pro/attach)
1. Install OpenSSH server if you want to connect through SSH. You can import it if you added your public Key to you GitHub account.
1. You are also given the option to install packages before completing the installation.
1. Wait for the reboot and keep the local IP address of the server for remote access.
1. You can assign a static IP address to make sure it won't change.

> Once you are done with the installation, you can enter with [**SSH** remote access](#-connect-to-ubuntu-server)
{: .prompt-info }

## 💽 Install dependencies

1. Docker and Docker Compose
1. Nvidia and Cuda
1. Git

## 🔗 Connect to Ubuntu Server

**Open a terminal** and enter the command to connect to the server through `ssh`

```shell
ssh <user_name>@<host_address>
```

> The connection won't be established if the configured `ssh private key` isn't on the system
{: .prompt-tip }

## 🧼 Clean boot drive from Live Environment (Before Install)

1. Boot into the Ubuntu live installer or recovery shell
1. Press `Ctrl+Alt+F2` or open a terminal
1 List disk :

    ```bash
    lsblk -d -o NAME,SIZE,MODEL
    ```
    {: .nolineno }

    - Example output :

    ```bash
    NAME   SIZE MODEL
    sda    500G Samsung SSD 860
    sdb    1.8T Seagate ST2000
    nvme0n1 256G WDC SN530
    ```
    {: .nolineno }

1. Choose a Disk, Let’s say you choose `sda` and wipe it
    - Fast method (wipes partition tables and superblocks):

    ```bash
    sudo wipefs -a /dev/sda
    sudo sgdisk --zap-all /dev/sda
    ```
    {: .nolineno }

    - Optional: Secure zero-fill (⚠️ very slow):

    ```bash
    sudo dd if=/dev/zero of=/dev/sda bs=1M status=progress
    ```
    {: .nolineno }

1. Confirm the drive is empty

    ```bash
    lsblk /dev/sda
    ```
    {: .nolineno }

> Once the cleanup is done, you can proceed with the installation
{: .prompt-info }
