---
layout: post
title: Install Bun
date: 2025-04-04 13:11 -0400
description: Installation guide for Bun.
author: philippe
categories: [Software]
tags: [guide, install]
image: 
    path: /assets/img/logo/bun.png
    alt: Install Bun
---

Bun is a new JavaScript runtime environment developed from the ground up to meet the needs of the modern JavaScript ecosystem. It pursues three major design goals, including speed. Bun boots and runs quickly. It extends JavaScriptCore, the powerful JavaScript engine built for Safari. Fast startup times mean fast apps and APIs.

<!-- markdownlint-disable MD033 -->
## Installation

1. Navigate to this site: [https://bun.sh](https://bun.sh){: target="_blank" }
1. Copy the installation command for your computer.

<iframe src="https://bun.sh" width="770px" height="850px" style="border-radius: 8px; border: none; overflow: hidden;"></iframe>

1. Run the command
    - With `powershell` for Windows
    - With `bash` for Linux & macOS

## Verification

Open your terminal and enter this command:

```shell
bun --version
# or
bun -v
```

> Bun should return the installed version.
![verification](/assets/img/installation/bun/verification.png){: w="200" style="border-radius: 10px;" .w-75 .normal .shadow }
{: .prompt-info }

## Justification

I decided to migrate the CX translation webhook to Bun-Hono to reduce the cold start time when Google Cloud Run needs to start an instance, and I also migrated the service to TypeScript to improve maintainability.

![startup_latency](/assets/img/installation/bun/startup_latency.png){: w="400" style="border-radius: 10px;" .shadow}
_Service startup latency graph_

- The exclamation points are deployments, when the changes were made on April 2nd and 3rd, 2025.
![environnement](/assets/img/installation/bun/environment_setup.png){: w="400" style="border-radius: 10px;" .shadow .right}
- During the first deployment phase, I changed the environment used to reduce startup times.
- The improvement wasn't significant, so I looked for other solutions. Since **Bun** is compatible with all **Node.js** projects, I tried migrating. The improvement was good, but there were some issues; the maintainability and readability of the project weren't the best. - That's why I migrated to **Hono** with **Bun** and **TypeScript** which would add type safety. In the second phase of deployment, after the migration, I deployed the project directly in TypeScript and the startup time had increased. That's why I had to compile the project with `tsc` in JavaScript and everything was perfect.
