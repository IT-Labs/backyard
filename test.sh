#!/bin/sh
docker-compose -f "fe/e2e_tests/docker-compose.yml" up sample-tests
docker-compose -f "fe/e2e_tests/docker-compose.yml" up sample-tests-empty