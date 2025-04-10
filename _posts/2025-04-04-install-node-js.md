---
layout: post
title: Install Node.js
date: 2025-04-04 13:45 -0400
description: Installation guide for Node.js.
author: philippe
categories: [Software]
tags: [guide, install]
toc: true
image: 
    path: /assets/img/banners/nodejs.png
    alt: Install Node.js
---

## Installation (without admin access)

1. Download the Node.js binary (.zip) [Download Node.js®](https://nodejs.org/en/download){: target="_blank" }  
    ![node installer bin](/assets/img/installation/node/node_installer_bin.png){: w="200" style="border-radius: 10px;" .shadow}
1. Unzip the contents to the location of your choice. In this example, we will use the `C:\Apps` folder.
1. Once unzipped, a new folder will be located in the directory, e.g., `node-v22.14.0-win-x64`
1. Open the utility to modify the environment variables for **your account**
1. Add the path to this folder to the `Path` variable

    Variable | Path
    -|-
    Path | `C:\Apps\node-v22.14.0-win-x64`

## Installation (with admin access)

1. Download the Node.js installer (.msi) [Download Node.js®](https://nodejs.org/en/download){: target="_blank" }  
    ![node installer msi](/assets/img/installation/node/node_installer_msi.png){: w="200" style="border-radius: 10px;" .shadow}
1. Run the installer and follow the instructions until the installation is complete.

## Verification

Open your terminal and enter these commands:

```shell
node -v
npm -v
```

>Node.js and npm should return the installed version.  
![verification](/assets/img/installation/node/verification.png){: w="200" style="border-radius: 10px;" .w-75 .normal .shadow }
{: .prompt-info }
