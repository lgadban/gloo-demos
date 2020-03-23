#!/bin/sh

set -x

kubectl apply -f oidc/petclinic.yaml
kubectl apply -f oidc/auth-config.yaml
