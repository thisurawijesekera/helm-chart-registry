{{/*
Expand the name of the chart.
*/}}
{{- define "dsre-charts-common.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "dsre-charts-common.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "dsre-charts-common.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "dsre-charts-common.labels" -}}
app.kubernetes.io.namespace: {{ .Values.namespace | quote }}
app.kubernetes.io.name: {{ .Values.name | quote }}
app.kubernetes.io.release: {{ .Release.Name }}
app.kubernetes.io.version: {{ .Values.imageTag }}
app.kubernetes.io.part-of: {{ .Values.namespace | quote }}
app.kubernetes.io.managed-by: {{ .Release.Service }}
app.kubernetes.io.environment: {{ .Values.environment | quote }}
helm.sh.chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
{{- end -}}

{{/*
Datadog labels
*/}}
{{- define "dsre-charts-common.datadog-labels" -}}
tags.datadoghq.com/env: {{ .Values.environment }}
tags.datadoghq.com/service: {{ .Values.name }}
tags.datadoghq.com/version: {{ .Values.imageTag }}
{{- end -}}

{{/*
Datadog Admission labels
*/}}
{{- define "dsre-charts-common.datadog-admission-labels" -}}
admission.datadoghq.com/enabled: "true"
{{- end -}}

{{/*
Datadog Admission annotations
*/}}
{{- define "dsre-charts-common.datadog-admission-annotations" -}}
admission.datadoghq.com/java-lib.version: v1.5.0
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "dsre-charts-common.selector-labels" -}}
app.kubernetes.io.name: {{ .Values.name | quote }}
app.kubernetes.io.release: {{ .Release.Name }}
{{- end -}}

{{/*
Linkerd Annotations
*/}}
{{- define "dsre-charts-common.linkerd-annotations" -}}
linkerd.io/inject: "enabled"
ad.datadoghq.com/linkerd-proxy.check_names: '["linkerd"]'
ad.datadoghq.com/linkerd-proxy.init_configs: '[{}]'
ad.datadoghq.com/linkerd-proxy.instances: |-
    [{
      "prometheus_url": "http://%%host%%:4191/metrics"
    }]
{{- end -}}