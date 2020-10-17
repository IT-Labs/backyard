#!/bin/sh
jmeter \
-JTARGET_HOST=api-dev \
-JTARGET_PORT=5000 \
-JTARGET_PROTOCOL=http \
-JTHREADS=10 \
-JRAMP_UP=3 \
-JLOOPS=15 \
-JGRAPHITE_HOST=graphite-sample \
-n -t tests/LoadItems.jmx \
-l jtl/test-plan_$(date +%Y-%m-%d-%H-%M-%S).jtl \
-j logs/jmeter_$(date +%Y-%m-%d-%H-%M-%S).log \
-e -o reports/$(date +%Y-%m-%d-%H-%M-%S)