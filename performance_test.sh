#!/bin/sh
root=$1
echo 'sitespeed volume folder-> '$root
docker run --network=sample-network --rm -v $root:/sitespeed.io sitespeedio/sitespeed.io:15.2.0-plus1 --graphite.host=graphite-sample urls.txt -b chrome -n 2