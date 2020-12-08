#!/bin/sh
jmeter \
-JTARGET_HOST=api-dev \
-JTARGET_PORT=5000 \
-JTARGET_PROTOCOL=http \
-JTHREADS=5 \
-JRAMP_UP=2 \
-JLOOPS=15 \
-JGRAPHITE_HOST=graphite-sample \
-n -t tests/LoadItems.jmx \
-l jtl/load_test-plan_$(date +%Y-%m-%d-%H-%M-%S).jtl \
-j logs/load_jmeter_$(date +%Y-%m-%d-%H-%M-%S).log \
-e -o reports/load_$(date +%Y-%m-%d-%H-%M-%S)