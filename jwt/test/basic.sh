#!/bin/sh

set -x

curl $(glooctl proxy url)/api/pets
