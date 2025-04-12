---
layout: post
title: Install Google Cloud CLI
date: 2025-04-04 13:45 -0400
description: Installation guide for Google Cloud CLI.
author: philippe
categories: [Software]
tags: [guide, install]
image: 
    path: /assets/img/banners/google-cloud.png
    alt: Install Google Cloud CLI
---


2,079 / 5,000
To develop locally with Google Cloud tools, we use the **Google Cloud CLI (gcloud)**. It must be installed and configured to enable secure local access to Google APIs from libraries.

## Google Cloud CLI

1. Download and install Google Cloud CLI (gcloud): [Install gcloud CLI](https://cloud.google.com/sdk/docs/install?hl=en){: target="_blank" }  
    ***The single-user installation option does not require administrator rights.***  
    ![installation 1](/assets/img/installation/gcloud/installation_1.png){: w="400" style="border-radius: 10px;" .w-75 .normal .shadow }
{: .prompt-tip }

1. At the end of the installation, make sure to select the `Run 'gcloud init' to config...` option.  
    ![installation 2](/assets/img/installation/gcloud/installation_2.png){: w="400" style="border-radius: 10px;" .w-75 .normal .shadow }

1. A terminal will open to run the command: `gcloud init`
    - Log in to your Google account
    - Select the project you want to work on
    - **Do not** choose a `default compute Region and Zone`

> Once this configuration is complete, you can use the `Google Cloud CLI (gcloud)` to manage Google resources
{: .prompt-info }
> [gcloud CLI Cheatsheet](https://cloud.google.com/sdk/docs/cheatsheet?hl=en){: target="_blank" }
{: .prompt-tip }

## Local Development Key

An authentication key is required to use the Google Cloud SDK, libraries (Python, Node.js, etc.), and APIs. To create an authentication key with your credentials, use this command in the terminal:

```shell
gcloud auth application-default login
```

> A local authentication key will be created with:
>
> - the Google credentials granted to your account.
> - access to the enabled APIs of your GCP project.
{: .prompt-info }
> For more information, you can consult Google's documentation: [HERE](https://cloud.google.com/docs/authentication/provide-credentials-adc?hl=en#how-to){: target="_blank" }
{: .prompt-tip }
