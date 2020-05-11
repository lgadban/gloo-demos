#!/bin/sh

set -x

kubectl delete secret petstore-apikey -n gloo-system
kubectl delete authconfig apikey-auth -n gloo-system
