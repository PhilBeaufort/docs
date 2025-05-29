---
layout: post
title: Golang API
date: 2025-05-29 18:25 -0400
description: Golang and Gin API Demo / Example
categories: [Code Example, Golang]
tags: [code, example, go]
---

Small Golang API example. The objective was to create a template for Golang that is extensible with a few feature.

- Folders to separate model, controllers and routes.
- Swagger documentation to easily get information and test API calls.
- Docker file to containerize the API for production.

The next step would be to use an ORM or SQL to connect and communicate with a database.

### Dependancies

- Gin
- Swagger (Swaggo)

```shell
go get github.com/gin-gonic/gin
go get -u github.com/swaggo/gin-swagger
go get -u github.com/swaggo/files
go install github.com/swaggo/swag/cmd/swag@latest
```

### Links

The repository is available here : [GitHub - PhilBeaufort/go-api](https://github.com/PhilBeaufort/go-api){: target="_blank" }

The API is deployed on my local server here : [https://go-api.beaufort.dev/](https://go-api.beaufort.dev/){: target="_blank" }
