#!/bin/sh

kubectl port-forward -n gloo-system svc/gateway-proxy 8080:80 &>/dev/null &

kubectl port-forward -n gloo-system svc/dex 32000:32000 &>/dev/null &

kubectl port-forward -n gloo-system deployment/glooe-grafana 3000

kubectl port-forward -n gloo-system svc/glooe-prometheus-server 3001:80

kubectl port-forward -n gloo-system deploy/gloo  9091:9091
