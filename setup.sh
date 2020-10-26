#!/bin/sh
docker-compose   -f "api/docker-compose.yml" up -d
docker-compose   -f "api-gateway/docker-compose.yml" up -d
docker-compose   -f "fe/e2e_tests/docker-compose-grid.yml" up -d
docker-compose   -f "fe/app/docker-compose.yml" up -d