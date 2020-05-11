#!/bin/sh

set -ex

helm install dex stable/dex -f oidc/dex-values.yaml --namespace gloo-system

kubectl apply -f oidc/petclinic.yaml
kubectl apply -f oidc/auth-config.yaml
kubectl apply -f oidc/secret.yaml
