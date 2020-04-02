#!/bin/sh

set -x

kubectl --namespace=gloo-system create configmap allow-jwt --from-file=opa/check-jwt.rego

kubectl apply -f opa/auth-config.yaml

#kubectl apply -f opa/petstore-opa.yaml
