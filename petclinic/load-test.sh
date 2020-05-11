#!/bin/zsh

for i in {{1..50}}
do
  curl http://35.222.37.0/ -o /dev/null -s -w "%{http_code}\n"
done

