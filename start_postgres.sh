#!/bin/bash
docker stop postgres_srv
docker rm postgres_srv
docker run -d -e POSTGRES_PASSWORD=pass -e POSTGRES_USER=user -e POSTGRES_DB=netology -v /DATABASE/postgres-data:/var/lib/postgresql/data --name postgres_srv postgres
