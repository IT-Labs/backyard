#!/bin/sh
jmeter \
-JGRID_URL=http://selenium-hub-sample:4444/wd/hub \
-JDATA_CSV=$PWD/tests/PageTraversing.csv \
-JSITE_URL=http://fe-dev:3000 \
-JTIME_ON_PAGE=3000 \
-JPAGES="/;/items;/about" \
-JTHREADS=2 \
-JRAMP_UP=4 \
-JLOOPS=2 \
-n -t tests/PageTraversing.jmx \
-l jtl/page_test-plan_$(date +%Y-%m-%d-%H-%M-%S).jtl \
-j logs/page_jmeter_$(date +%Y-%m-%d-%H-%M-%S).log \
-e -o reports/page_$(date +%Y-%m-%d-%H-%M-%S)