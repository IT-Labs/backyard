#!/bin/sh
docker-compose -f "api/docker-compose.yml" down
docker-compose -f "api-gateway/docker-compose.yml" down
docker-compose -f "fe/e2e_tests/docker-compose-grid.yml" down
docker-compose -f "fe/e2e_tests/docker-compose.yml" down
docker-compose -f "fe/app/docker-compose.yml" down
docker-compose -f "jmeter/docker-compose.yml"  down
docker-compose -f "docker-compose-sonar.yml"  down
docker-compose -f "docker-compose-monitoring.yml"  down
docker-compose -f "docker-compose-infrastructure.yml" down
