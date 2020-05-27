#!/bin/sh
./clean.sh
./volume_restore.sh $1
./setup.sh
