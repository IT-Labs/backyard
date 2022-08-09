#!/bin/sh
# run and detach
docker compose  -f ../docker-compose-secutity.yml  up -d
# save logs to a file in the background
docker compose -f ../docker-compose-secutity.yml logs --no-log-prefix -f grype-sample > grype_report.txt
