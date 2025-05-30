---
layout: post
title: Golang API
date: 2025-05-29 18:25 -0400
description: Golang and Gin API Demo / Example
categories: [Code Example, Golang]
tags: [code, example, go]
---

Small Golang API example. The objective was to create a template for Golang that is extensible with a few features.

- Folders to separate model, controllers and routes.
- Swagger documentation to easily get information and test API calls.
- Docker file to containerize the API for production.

I find that there is a lot of code when using an ORM. To change things a little, I used SQLC, a library used to generate GO code for SQL databases with SQL code of the schema and queries [sqlc.dev](https://sqlc.dev/){: target="_blank" }  
The code generated enables the usage of `functions` communicating with the database after connection. The only thing missing was that that database is not initialized. I used `golang-migrate` that runs before application startups, the table is created if it doesn't exist.

The application is now started with a `docker-compose` to start a PostgreSQL database, setup environment variables and start the API that connects to it.

### Dependencies

- Gin
- Swagger (Swaggo)
- pgx (v5)
- lib/pq
- sqlc
- golang-migrate

```shell
go get github.com/gin-gonic/gin
go get -u github.com/swaggo/gin-swagger
go get -u github.com/swaggo/files
go install github.com/swaggo/swag/cmd/swag@latest
go install github.com/sqlc-dev/sqlc/cmd/sqlc@latest
go get github.com/jackc/pgx/v5
go get github.com/jackc/pgx/v5/pgxpool
go get github.com/lib/pq
go get -u github.com/golang-migrate/migrate/v4
go get -u github.com/golang-migrate/migrate/v4/database/postgres
go get -u github.com/golang-migrate/migrate/v4/source/file
```

### Links

The repository is available here : [GitHub - PhilBeaufort/go-api](https://github.com/PhilBeaufort/go-api){: target="_blank" }

The API is deployed on my local server here : [https://go-api.beaufort.dev/](https://go-api.beaufort.dev/){: target="_blank" }
