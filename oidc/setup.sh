#!/bin/sh

set -x

helm install dex stable/dex -f dex-values.yaml --namespace gloo-system

kubectl apply -f oidc/petclinic.yaml
kubectl apply -f oidc/auth-config.yaml
