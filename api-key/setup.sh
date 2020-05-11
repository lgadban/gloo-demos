#!/bin/sh
set -x

kubectl apply -f apikey-secret.yaml
kubectl apply -f auth-config.yaml
