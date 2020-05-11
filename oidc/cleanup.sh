#!/bin/sh

set -x

kubectl delete authconfig oidc-dex -n gloo-system
kubectl delete vs petclinic -n gloo-system
kubectl delete secret oauth -n gloo-system

helm uninstall dex --namespace gloo-system
