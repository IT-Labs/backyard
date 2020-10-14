#!/bin/sh
docker-compose down
docker build --tag fe-sample .
