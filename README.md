# Introduction

Purpose of this repository to give real working examples for development and testing the code.
This repository contains a full working local environment, where you can execute your application with minimum installed tools [setup](#root-setup).

## Stack

- Java
- Spring Boot
- Gradle
- React
- Typescript
- Nightwatch
- Postgres
- Docker
- Docker compose
- Selenium grid
- Sonar
- Grafana
- Prometheus
- sitespeed.io
- Jmeter 

# Readme

Following section describe which action can be performed, more details about the project can be found in

- api [readme](api/README.md)
- fe [readme](fe/app/README.md)
- e2e tests [readme](fe/e2e_tests/Readme.md)

# Local environment

For local development please check the Readme section for each project and install appropriate requirements

## Root setup

- Docker https://docs.docker.com/install/ and Docker compose https://docs.docker.com/compose/install/
- Ensure you are sharing the drive where you clone the project https://docs.docker.com/docker-for-windows/#resources
- Bash support for windows https://gitforwindows.org/
- VNC viewer [RealVNC](https://www.realvnc.com/en/connect/download/viewer/) for accessing selenium grid node when test are executed.
- Configure vnc: server-> localhost:5901, password-> secret, Name -> Chrome:5901

### Linux

execute following commands to set correct permissions :

- find -type f -iname "\*.sh" -exec chmod +x {} \;
- find -type f -iname "gradlew" -exec chmod +x {} \;

## Build

Build project is recreating the artifact used by dockers,
and can be performed by calling [build.sh](build.sh). This script stops all parts which will be rebuild. If you want to rebuild single service, you can copy appropriate line and execute.

## Test

Following section present steps for running the test from scratch or repeating

- restart test environment: [restart.sh](restart.sh) path\to\repository; example : C:/Projects/IT-Labs/backyard
  example :`restart.sh C:/Projects/IT-Labs/backyard`
- run test: [test.sh](test.sh) (If test(s) are not destructive (only read data from database) you can run them multiple times)

## Volume backup

If you want to backup volume,because [restart.sh](restart.sh) is restoring your volume on each run
you should run the [backup script](volume_backup.sh)
example : `volume_backup.sh C:/Projects/IT-Labs/backyard`

## Jmeter test

- download [jmeter](https://jmeter.apache.org/download_jmeter.cgi)

### Development (GUI mode)

- extract and run jmeter.(bat,sh)
- open existing .jmx files or create a new one in the following [location](jmeter/tests)

### Non-GUI mode run

this mode is using docker to run test, outputs can be found [location](jmeter)

- tune the test J parameters in jmeter.sh(jmeter.sh)
- jmeter.sh(jmeter.sh)
### Reports results 
 - html reports can be found  [location](jmeter/reports) 
 - stats are send to graphite by using Backend Listener to Graphite
 - Grafana (Coming soon)  

## Performance test

### Dashboard and storage setup

- ensure api-postgres container is running (it is used by grafana to store credentials and dashboards)
- run [monitoring docker compose](docker-compose-monitoring.yml) `docker-compose -f "docker-compose-monitoring.yml" up -d`
- navigate to http://localhost:9092/ , credentials admin/admin

### SiteSpeed Run

restart test environment: [performance_test.sh](performance_test.sh) path\to\repository\metrics (NOTE : this path is required because is volume for results and contains urls for running)
example : `performance_test.sh C:/Projects/IT-Labs/backyard/metrics`

### Visualize the test

- open VNC before running test
- open generated report json -> fe\e2e\*tests\reports\cucumber.json or generated html fe\e2e_tests\reports\test**\*\*\***.html
- open exported sitespeed.io [folder](metrics)
- open http://localhost:9092/dashboards

### Links

- https://www.sitespeed.io/documentation/sitespeed.io/configuration/
- https://www.sitespeed.io/documentation/sitespeed.io/lighthouse/
- https://www.sitespeed.io/documentation/sitespeed.io/performance-dashboard/#up-and-running-in-almost-5-minutes
- https://grafana.com/grafana/dashboards/10288
- https://github.com/sitespeedio/grafana-bootstrap-docker/tree/main/dashboards/graphite

## Sonar

### Setup

#### WSL 2 setup :

this is solving the production elastic search setup : https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html#_set_vm_max_map_count_to_at_least_262144

- open powershell wsl -d docker-desktop
- sysctl -w vm.max_map_count=262144
  NOTE: for now this command must be run after each windows system restart

#### Run Sonar

- run `docker-compose -f docker-compose-sonar.yml up -d sonarqube-sample`
- navigate to sonar [admin](http://localhost:9001)
- login admin/admin
- create sample-api for java , generate token i paste in docker-compose-sonar.yml
- create sample-fe for fe , generate token i paste in docker-compose-sonar.yml

- run `docker-compose -f docker-compose-sonar.yml up -d sonar-fe` for FE analysis
- run `docker-compose -f docker-compose-sonar.yml up -d sonar-api` for API analysis
- remove all containers : `docker-compose -f docker-compose-sonar.yml down`
