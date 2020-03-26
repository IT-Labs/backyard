# Introduction

Purpose of this repository to give real working examples for development ,testing and deploying the code.
This repository contains a full working local environment, where you can execute your application with minimum installed tools [setup](#root-setup).

## Stack

- Java
- Spring Boot
- Gradle
- React
- Typescript
- Nightwatch
- Docker
- Docker compose
- Selenium grid

# Readme

Following section describe which action can be performed, more details about the project can be found in

- api [readme](api/README.md)
- fe [readme](fe/app/README.md)
- e2e tests [readme](fe/e2e_tests/Readme.md)
- infrastructure TBD

# Local environment

For local development please check the Readme section for each project and install appropriate requirements

## Root setup

- Docker https://docs.docker.com/install/ and Docker compose https://docs.docker.com/compose/install/
- Bash support for windows https://gitforwindows.org/
- VNC viewer [RealVNC](https://www.realvnc.com/en/connect/download/viewer/) for accessing selenium grid node when test are executed.
- Configure vnc: server-> localhost:5901, password-> secret, Name -> Chrome:5901
### Linux 
execute folowing commands to set correct permissions :
- find -type f -iname "*.sh" -exec chmod +x {} \;
- find -type f -iname "gradlew" -exec chmod +x {} \;

## Build

Build project is recreating the artifact used by dockers,
and can be performed by calling [build.sh](build.sh). This script stops all parts which will be rebuild. If you want to rebuild single service, you can copy appropriate line and execute.

## Test

Following section present steps for running the test from scratch or repeating

- restart test environment: [restart.sh](restart.sh)
- run test: [test.sh](test.sh) (If test(s) are not destructive (only read data from database) you can run them multiple times)

### Visualize the test

- open VNC before running test
- open generated report json -> fe\e2e_tests\reports\cucumber.json or generated html fe\e2e_tests\reports\test_******.html 

# Deploy

TBD
