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
<!-- markdownlint-disable MD046 -->
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

    Reference: [Docker docs, ubuntu install](https://docs.docker.com/engine/install/ubuntu/)

    1. Set up Docker's `apt` repository.

    ```shell
    # Add Docker's official GPG key:
    sudo apt-get update
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
        $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \ 
        sudo tee /etc/apt/sources.list.d/docker.list > /dev/null 
    sudo apt-get update
    ```
    {: .nolineno }

    1. To install the latest version, run

    ```shell
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    ```
    {: .nolineno }

    1. Enable Docker at boot
    ```shell
    sudo systemctl enable docker
    ```
    {: .nolineno
    }
    1. Verify that the installation is successful by running the hello-world image:

    ```shell
    sudo docker run hello-world
    ```
    {: .nolineno }

    > Add current user to the docker group:  
    > `sudo usermod -aG docker $USER`  
    > - logout and login to apply or use the command `newgrp docker` to apply immediately.
    {: .prompt-info}
1. Nvidia and Cuda

    1. Install nvidia drivers

        - Check if GPU is detected

        ```shell
        lspci | grep -i nvidia
        lsmod | grep nvidia
        ```
        {: .nolineno }

        - If GPU is detected install nvidia drivers

        ```shell
        sudo apt install nvidia-driver-535-server -y
        ```
        {: .nolineno }

        - Reboot and complete key registration for secure boot if enabled

        ```shell
        sudo reboot
        ```
        {: .nolineno }

    1. Cuda toolkit Installer (Ubuntu2404 x86_64)

    ```shell
    wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-keyring_1.1-1_all.deb
    sudo dpkg -i cuda-keyring_1.1-1_all.deb
    sudo apt-get update
    sudo apt-get -y install cuda-toolkit-12-8
    ```
    {: .nolineno}

    Reference: [developer.nvidia.com](https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=Ubuntu&target_version=24.04&target_type=deb_network)

    1. 🛠️ Configure Docker to Use NVIDIA Runtime

    ```shell
    sudo nvidia-ctk runtime configure --runtime=docker
    sudo systemctl restart docker
    ```
    {: .nolineno }

    1. Verify if it works

    ```shell
    docker run --rm --gpus all nvidia/cuda:12.3.0-base-ubuntu22.04 nvidia-smi
    ```
    {: .nolineno }

1. Others

    1. secure and update

    ```shell
    sudo apt update && sudo apt upgrade -y
    sudo apt install ufw fail2ban -y
    ```
    {: .nolineno }

    ```shell
    sudo ufw allow OpenSSH
    sudo ufw enable
    ```
    {: .nolineno }

    > - Fail2ban helps prevent brute-force SSH attacks.
    > - Optional: Change SSH port (/etc/ssh/sshd_config) and restart `sudo systemctl restart sshd`.
    {: .promt-info}

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
