function proxy-dbug-logs() {

  kubectl port-forward -n gloo-system deploy/gateway-proxy 19000 &
  GPID=$!

  sleep 2
  curl -X POST "localhost:19000/logging?level=debug"

  kill -9 $GPID

}
