#!/bin/sh
docker-compose   -f "docker-compose-infrastructure.yml" up -d
echo 'wait 30 sec before start next initiization'
sleep 30 
docker-compose   -f "api-config/docker-compose.yml" up -d
echo 'wait 3 min before start next initiization'
sleep 3m
docker-compose   -f "api/docker-compose.yml" up -d
docker-compose   -f "api-gateway/docker-compose.yml" up -d
docker-compose   -f "docker-compose-grid.yml" up -d
docker-compose   -f "fe/app/docker-compose.yml" up -d
./setup-git-hook.sh
