#!/bin/bash

helm install glooe glooe/gloo-ee -n gloo-system \
  --set-string license_key=$GLOO_LICENSE_KEY \
  --version 1.5.1 \
  --set "observability.enabled=false" \
  --set "prometheus.enabled=false" \
  --set "grafana.defaultInstallationEnabled=false" \
  --create-namespace

