#!/bin/sh

set -x

kubectl -n gloo-system port-forward svc/gateway-proxy 8080:80 &>/dev/null &
kubectl -n gloo-system port-forward svc/dex 32000:32000 &>/dev/null &

