#!/bin/sh
docker-compose down
docker build --tag fe-sample .
docker-compose  up -d