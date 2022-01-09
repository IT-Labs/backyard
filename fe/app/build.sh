#!/bin/sh
docker-compose down
docker build --no-cache --tag fe-sample .
