#!/bin/bash
docker run -d -e POSTGRES_PASSWORD=pass -e POSTGRES_USER=user -e POSTGRES_DB=netology -v /DATABASE/postgres-data:/var/lib/postgresql/data --name postgres_srv postgres
