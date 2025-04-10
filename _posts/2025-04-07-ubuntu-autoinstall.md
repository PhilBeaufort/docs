---
layout: post
title: Testing Ubuntu autoinstall
date: 2025-04-07 00:57 -0400
description: Testing autoinstall with ubuntu server
categories: [Documentation, Server]
tags: [documentation, server, ubuntu]
---

<!-- markdownlint-disable MD031 -->
<!-- markdownlint-disable MD007 -->
## 🔧 Setup a boot and installation media (Autoinstall not working)

1. Download the most recent [Ubuntu server LTS](https://ubuntu.com/download/server)
1. Use [Rufus](https://rufus.ie/en/) and USB Key to create a Boot Media
1. Once the boot media is completed, open the USB with a file manager
1. Go to `/boot/grub/` directory
1. Edit `grub.cfg` and add this line under the first `menuentry` block:

    ```shell
    set autoinstall="ds=nocloud;s=/cdrom/nocloud/"
    ```
    {: file="/boot/grub/grub.cfg" .nolineno }

    - So it looks something like:

    ```shell
    menuentry "Install Ubuntu Server" {
        set gfxpayload=keep
        linux   /casper/vmlinuz --- autoinstall ds=nocloud\;s=/cdrom/nocloud/
        initrd  /casper/initrd
    }
    ```
    {: file="/boot/grub/grub.cfg" .nolineno }

1. 🧾 Create `nocloud` Directory with Config
    In the root of your USB (same level as `boot/`, `casper/`), create a new folder:
    ```text
    /nocloud/
    ```
    {: .nolineno }

- Create `user-data`, copy and complete the script bellow
    - SSH-only access
    - Docker & Compose ready
    - UFW firewall with OpenSSH & NGINX allowed
    - NVIDIA drivers and GPU container support
    - Auto-start Docker & secure SSH config
    - Replace the <user_name> and <public_ssh_key> tags with yours

```yaml
#cloud-config
autoinstall:
version: 1

identity:
  hostname: <user_name>-server
  username: <user_name>
  password: "" # No password

ssh:
  install-server: true
  authorized-keys:
    - <public_ssh_key>

storage:
  layout:
  name: direct

packages:
  - docker.io
  - git
  - curl
  - ufw
  - software-properties-common
  - nvidia-driver-570-server # Adjust if using a different version

user-data:
  disable_root: true
  ssh_pwauth: false

users:
  - name: <user_name>
    groups: [sudo, docker]
    shell: /bin/bash
    lock_passwd: true
    sudo: ALL=(ALL) NOPASSWD:ALL
    ssh_authorized_keys:
      - <public_ssh_key>

late-commands:
  # Enable Docker at boot
  - curtin in-target -- systemctl enable docker

  # Install Docker Compose (latest version)
  - curtin in-target -- bash -c "curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose"
  - curtin in-target -- chmod +x /usr/local/bin/docker-compose

  # Setup UFW
  - curtin in-target -- ufw allow OpenSSH
  - curtin in-target -- ufw allow 'Nginx Full'
  - curtin in-target -- ufw --force enable

  # Harden SSH
  - curtin in-target -- sed -i 's/^#PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config

  # Install NVIDIA Docker runtime (for container GPU support)
  - curtin in-target -- bash -c "distribution=$(. /etc/os-release; echo $ID$VERSION_ID) && \
    curl -s -L https://nvidia.github.io/libnvidia-container/gpgkey | gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit.gpg && \
    curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit.gpg] https://#' | \
    tee /etc/apt/sources.list.d/nvidia-container-toolkit.list"

  - curtin in-target -- apt-get update
  - curtin in-target -- apt-get install -y nvidia-container-toolkit
  - curtin in-target -- nvidia-ctk runtime configure --runtime=docker
  - curtin in-target -- systemctl restart docker

```
{: file="/nocloud/user-data" }

- Create `meta-data`, copy and complete the content bellow

```yaml
instance-id: <user_name>-install
local-hostname: <user_name>-server
```
{: file="/nocloud/user-data" }
