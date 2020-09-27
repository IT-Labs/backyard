#!/bin/sh
cd jmeter
mkdir reports
cd ..
docker-compose -f "jmeter/docker-compose.yml"  down
docker-compose -f  "docker-compose-monitoring.yml" up -d
docker-compose -f  "jmeter/docker-compose.yml" up