---
layout: post
title: Ubuntu server install dependencies
date: 2025-04-09 00:02 -0400
---

## Docker and Docker Compose

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

## Nvidia and Cuda

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

## Others

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