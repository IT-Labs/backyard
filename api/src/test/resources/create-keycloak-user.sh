#!/usr/bin/env bash
 cd /opt/jboss/keycloak/bin
./kcadm.sh config credentials --server http://localhost:8080/auth --realm master --user admin --password admin
./kcadm.sh create users -s username=sample -s enabled=true -r realm-sample
./kcadm.sh add-roles --uusername sample --rolename sample-role -r realm-sample
./kcadm.sh set-password -r realm-sample --username sample --new-password sample
