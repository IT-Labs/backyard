#!/bin/sh
docker-compose -f "api/docker-compose.yml" down
docker-compose -f "fe/e2e_tests/docker-compose-grid.yml" down
docker-compose -f "fe/e2e_tests/docker-compose.yml" down
docker-compose -f "fe/app/docker-compose.yml" down
