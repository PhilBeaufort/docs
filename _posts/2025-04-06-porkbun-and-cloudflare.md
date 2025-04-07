---
layout: post
title: Porkbun and Cloudflare
date: 2025-04-06 18:15 -0400
description: Configuration of Porkbun with Cloudflare.
categories: [Documentation, Networking]
tags: [documentation, network]
image: 
    path: /assets/img/logo/porkbun&cloudflare.png
    alt: Documentation avec Jekyll
---

For security reason, it is suggested to separate the service registrar and DNS

That's why I plan to do this :

- [**Porkbun**][porkbun] as registrar
- [**Cloudflare**][cloudflare] as DNS with free plan

## Porkbun initial config

After buying a domain from Porkbun, here is the initial config :

### DNS Records

TYPE|HOST|ANSWER|TTL
-|-|-|-
ALIAS|`<domain>`|pixie.porkbun.com|600
CNAME|`*.<domain>`|pixie.porkbun.com|600

### Nameservers

```text
curitiba.ns.porkbun.com
fortaleza.ns.porkbun.com
maceio.ns.porkbun.com
salvador.ns.porkbun.com
```

## Configure Cloudflare DNS

1. Create a Cloudflare account with free plan.
1. `Add a domain`, enter your domain and select the DNS records to keep.
1. Return to Porkbun, disable DNSSEC if enabled.
1. Replace the name servers with the ones provided by Cloudflare.

    ```text
    kai.ns.cloudflare.com
    meadow.ns.cloudflare.com
    ```

1. Registrars take up to 24 hours to process nameserver changes (quicker in most cases). Cloudflare will send an email when your domain is active.

[porkbun]: https://porkbun.com/
[cloudflare]: https://www.cloudflare.com/
