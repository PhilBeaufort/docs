---
layout: post
title: Ubuntu server install dependencies
date: 2025-04-09 00:02 -0400
description: Install / Remove dependencies for ubuntu server
categories: [Documentation, Server]
tags: [documentation, server, ubuntu]
image: 
    path: /assets/img/banners/ubuntu_server.png
    alt: Ubuntu server
---

## Docker and Docker Compose

Reference: [Docker docs, ubuntu install](https://docs.docker.com/engine/install/ubuntu/)

```shell
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to apt sources:
echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \ 
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null 
sudo apt-get update

# Install latest version
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Enable Docker at boot
sudo systemctl enable docker
```
{: .nolineno }

Verify that the installation is successful by running the hello-world image:

```shell
sudo docker run hello-world
```
{: .nolineno }

> Add current user to the docker group:  
> `sudo usermod -aG docker $USER`  
> - logout and login to apply or use the command `newgrp docker` to apply immediately.
{: .prompt-info}

## Nvidia and Cuda

1. Install nvidia drivers

```shell
# Check if GPU is detected
lspci | grep -i nvidia
lsmod | grep nvidia

# If GPU is detected install nvidia drivers (version optional)
sudo apt install nvidia-driver-535-server -y

# Reboot and complete key registration for secure boot if enabled
sudo reboot
```
{: .nolineno }

1. Cuda toolkit

```shell
# Install Cuda toolkit Installer (Ubuntu2404 x86_64)
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

## Remove Docker

```bash
#Stop docker service 
sudo systemctl stop docker
sudo systemctl stop docker.service
sudo systemctl stop docker.socket

#Uninstall docker packages
sudo apt-get purge docker-ce docker-ce-cli containerd.io

# Remove Docker images containers, volumes and networks
sudo rm -rf /var/lib/docker

# Remove Docker group
sudo groupdel docker

# Remove Docker binairies:
sudo rm /usr/local/bin/docker-compose
sudo rm /usr/local/bin/docker

# Clean up unused dependencies
sudo apt-get autoremove
sudo apt-get clean

# Check if compenent with "docker" are still present, remove if needed
dpkg -l | grep docker
```
{: .nolineno }

## Remove Dokploy

```bash
# Stop instance
sudo systemctl stop dokploy

# Uninstall
sudo rm -rf /usr/local/bin/dokploy

# Delete configuration files
sudo rm -rf ~/.dokploy
sudo rm -rf /etc/dokploy

# Clean up leftover dependencies
sudo apt-get autoremove
sudo apt-get clean
```
{: .nolineno }

# Remove snap

```bash
# check if snap of app exists
snap list | grep docker

# Remove snap app
sudo snap remove docker
```
{: .nolineno }