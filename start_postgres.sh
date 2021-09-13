#!/bin/bash
docker stop postgres_srv
docker rm postgres_srv
docker run -d -e POSTGRES_PASSWORD=pass -e POSTGRES_USER=user -v /DATABASE/postgres-data:/var/lib/postgresql/data -v /DATABASE/postgres-backup:/mnt --name postgres_srv postgres:latest
