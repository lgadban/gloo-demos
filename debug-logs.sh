#!/bin/zsh

set -x

kubectl port-forward -n gloo-system deploy/gateway-proxy 19000 &
GPID=$!

sleep 5
curl -X POST localhost:19000/logging\?level=debug

kill -9 $GPID

#curl -X PUT localhost:9092/logging -d '{"level":"debug"}'
#curl -X PUT localhost:9091/logging -d '{"level":"debug"}'

