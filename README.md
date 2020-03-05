#Introduction
This repository contains full working e2e test envoriment using dockers, docker compose, nigthwatch, selenium grid

#Setup enviroment :

- Docker https://docs.docker.com/install/ and Docker compose https://docs.docker.com/compose/install/
- bash support for windows https://gitforwindows.org/
- VNC viewer [RealVNC](https://www.realvnc.com/en/connect/download/viewer/)
  - Configure vnc : server-> localhost:5901 , password-> secret , Name -> Chrome:5901

#Run
Folowing section describe which action can be performed , more details about project can be found in

- api [readme](./api/HELP.md)
- fe [readme](./fe/app/README.md)
- e2e tests [readme](./fe/e2e_tests/Readme.md)

##Build
Build projects is recreating the artefacts used be dockers ,
and can be performed by caling (build.sh)[build.sh] this script stops all parts which will be rebuild, If you want to rebuild single service, you can copy appropriate line and excute

##Test
Folowing section present steps for running test from scratch or repeating

- restart test enviroment : [restart.sh](restart.sh)
- run test : [test.sh](test.sh) ( If test(s) are not destructive (only read data from database) you can run multiple times )

### visually the test

- open VNC before running test
- open generated repor [json](./reports/cucumber.json) or generated html
