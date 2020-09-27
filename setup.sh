#!/bin/sh
docker-compose   -f "docker-compose-infrastructure.yml" up -d
docker-compose   -f "api/docker-compose.yml" up -d
docker-compose   -f "api-gateway/docker-compose.yml" up -d
docker-compose   -f "docker-compose-grid.yml" up -d
docker-compose   -f "fe/app/docker-compose.yml" up -d
./setup-git-hook.sh
