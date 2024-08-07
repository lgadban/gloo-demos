{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}

{{/* Used to update the values during the render of a template. Useful for taking user-friendly gloo-ee
     values and renaming them to gloo's expected format without leaking implementation details */}}
{{- define "gloo.updatevalues" -}}
{{- if .Values.global.extensions.extAuth.envoySidecar -}}
{{- $plugins := .Values.global.extensions.extAuth.plugins -}}
{{- range $proxyName, $proxy := .Values.gatewayProxies -}}
{{- $_ := set (index $.Values.gatewayProxies $proxyName) "extraContainersHelper" "gloo.extauthcontainer" -}}
{{- if $plugins -}}
{{- $_ = set (index $.Values.gatewayProxies $proxyName) "extraInitContainersHelper" "gloo.extauthinitcontainers" -}}
{{- $_ = set (index $.Values.gatewayProxies $proxyName) "extraVolumeHelper" "gloo.extauthpluginvolume" -}}
{{- end -}} # if plugins
{{- if $.Values.global.glooMtls.enabled }}
{{- $_ = set (index $.Values.gatewayProxies $proxyName) "extraListenersHelper" "gloo.sidecarlisteners" -}}
{{- end -}} # end glooMtls.enabled
{{- end -}} # end range
{{- end -}} # if envoySidecar
{{- end -}} # end define

{{/* Volume definition needed for ext auth plugin setup */}}
{{- define "gloo.extauthpluginvolume" -}}
- emptyDir: {}
  name: auth-plugins
{{- end -}}

{{/* Listener definition needed for ext auth setup */}}
{{- define "gloo.sidecarlisteners" -}}
- name: gloo_xds_mtls_listener
  address:
    socket_address:
      address: 127.0.0.1
      port_value: 9955
  filter_chains:
    - filters:
      - name: envoy.tcp_proxy
        config:
          stat_prefix: gloo_mtls
          {{- if $.Values.k8s }}
          cluster: gloo.{{ $.Release.Namespace }}.svc.{{ $.Values.k8s.clusterName}}:{{ $.Values.gloo.deployment.xdsPort }}
          {{- else }}
          cluster: gloo.{{ $.Release.Namespace }}.svc.{{ $.Values.gloo.k8s.clusterName}}:{{ $.Values.gloo.gloo.deployment.xdsPort }}
          {{- end}}
{{- end -}}

{{/* Init container definition for extauth plugin setup */}}
{{- define "gloo.extauthinitcontainers" -}}
{{- $extAuth := .Values.global.extensions.extAuth -}}
{{- range $name, $plugin := $extAuth.plugins -}}
{{- $pluginImage := merge $plugin.image $.Values.global.image -}}
- image: {{template "gloo.image" $pluginImage}}
  {{- if $pluginImage.pullPolicy }}
  imagePullPolicy: {{ $pluginImage.pullPolicy }}
  {{- end}}
  name: plugin-{{ $name }}
  volumeMounts:
    - name: auth-plugins
      mountPath: /auth-plugins
{{end}} {{/* don't strip the newline here for rendering purposes */}}
{{- end}}

{{/* Container definition for extauth, used in extauth deployment and
     gateway-proxy (envoy) sidecar over unix domain socket

     Expects both the keys Values and ExtAuthMode in its root context, with the latter
     taking either the value "sidecar" or "standalone". It will default to "sidecar"
     if the value is not provided. */}}
{{- define "gloo.extauthcontainer" -}}
{{- $extAuth := .Values.global.extensions.extAuth -}}
{{- $image := $extAuth.deployment.image -}}
{{- $statsConfig := coalesce $extAuth.deployment.stats .Values.global.glooStats -}}
{{- if .Values.global -}}
{{- $image = merge $extAuth.deployment.image .Values.global.image -}}
{{- end -}}
{{- $extAuthServerPort := .Values.global.glooMtls.enabled | ternary 8084 $extAuth.deployment.port -}}
{{- $extAuthMode := default "sidecar" .ExtAuthMode -}}
- image: {{template "gloo.image" $image}}
  imagePullPolicy: {{ $image.pullPolicy }}
  name: {{ $extAuth.deployment.name }}
  env:
    - name: POD_NAMESPACE
      valueFrom:
        fieldRef:
          fieldPath: metadata.namespace
    - name: SERVICE_NAME
      value: {{ $extAuth.serviceName  | quote }}
    - name: GLOO_ADDRESS
{{- if $extAuth.deployment.glooAddress }}
      value: {{ $extAuth.deployment.glooAddress }}
{{- else }}
      {{- if .Values.global.glooMtls.enabled }}
      value: "127.0.0.1:9955"
      {{- else }}
      {{- if .Values.gloo.gloo }}
      value: gloo:{{ .Values.gloo.gloo.deployment.xdsPort }}
      {{- else }}
      value: gloo:{{ .Values.gloo.deployment.xdsPort }}
      {{- end }}
      {{- end }}
{{- end }}
    - name: SIGNING_KEY
      valueFrom:
        secretKeyRef:
          name: {{ $extAuth.signingKey.name }}
          key: signing-key
    {{- if $extAuth.deployment.debugPort }}
    - name: DEBUG_PORT
      value: {{ $extAuth.deployment.debugPort | quote }}
    {{- end }}
    - name: SERVER_PORT
      value: {{ $extAuthServerPort | quote }}
    {{- if eq $extAuthMode "sidecar" }}
    - name: UDS_ADDR
      value: "/usr/share/shared-data/.sock"
    {{- end }}
    {{- if $extAuth.userIdHeader }}
    - name: USER_ID_HEADER
      value: {{ $extAuth.userIdHeader  | quote }}
    {{- end }}
    {{- if $statsConfig.enabled }}
    - name: START_STATS_SERVER
      value: "true"
    {{- end}}
    {{- if $extAuth.tlsEnabled }}
    - name: TLS_ENABLED
      value: "true"
    {{- end}}
    {{- if $extAuth.certPath }}
    - name: CERT_PATH
      value: {{ $extAuth.certPath }}
    {{- end}}
    {{- if $extAuth.keyPath }}
    - name: KEY_PATH
      value: {{ $extAuth.keyPath }}
    {{- end}}
  {{- if ne $extAuthMode "sidecar" }}
  readinessProbe:
    exec:
      command:
        - /bin/sh
        - -c
        - nc -z localhost {{ $extAuthServerPort }}
    initialDelaySeconds: 1
    failureThreshold: 3
    successThreshold: 1
  {{- end }}
  {{- if or $extAuth.plugins (eq $extAuthMode "sidecar") }}
  volumeMounts:
  {{- if eq $extAuthMode "sidecar" }}
  - name: shared-data
    mountPath: /usr/share/shared-data
  {{- end }}
  {{- if $extAuth.plugins }}
  - name: auth-plugins
    mountPath: /auth-plugins
  {{- end }}
  {{- end }}
{{- end }}
