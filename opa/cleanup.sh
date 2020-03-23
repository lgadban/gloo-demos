#!/bin/sh

set -x

kubectl --namespace=gloo-system delete configmap allow-jwt

kubectl delete authconfig jwt-opa -n gloo-system
kubectl delete virtualservice petstore -n gloo-system
