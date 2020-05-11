#!/bin/sh
set -x

kubectl create -f https://raw.githubusercontent.com/jaegertracing/jaeger-kubernetes/master/all-in-one/jaeger-all-in-one-template.yml

kubectl patch gateway -n gloo-system gateway-proxy --patch "$(cat gateway-patch.yaml)" --type merge
