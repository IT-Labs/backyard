#!/bin/sh 
docker-compose -f  "docker-compose-monitoring.yml" up -d
root=$1
echo 'sitespeed volume folder-> '$root
echo 'private urls run'
docker run --network=sample-network --rm -v $root:/sitespeed.io sitespeedio/sitespeed.io:16.0.1 \
 --graphite.host=graphite-sample  --browsertime.my.host="http://fe-dev:3000/"  --browsertime.my.password="sample" \
 --browsertime.my.username="sample" \
 --browsertime.my.pages='items,Items Page;about,About Page' \
privateUrls.js --multi -b chrome -n 1
echo 'public urls run'
 docker run --network=sample-network --rm -v $root:/sitespeed.io sitespeedio/sitespeed.io:16.0.1-plus1 \
 --graphite.host=graphite-sample publicUrls.txt -b chrome -n 1