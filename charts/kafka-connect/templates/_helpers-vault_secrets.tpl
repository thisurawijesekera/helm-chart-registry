{{/*
Generates Vault injection secrets
*/}}
{{- define "dsre-charts-common.secret-template-common" -}}
{{- if hasKey .Values.secrets "sharedSecrets" -}}
{{- if gt (len .Values.secrets.sharedSecrets) 0 -}}
{{- range $group := .Values.secrets.sharedSecrets -}}
{{- if hasKey $group "vaultPath" -}}
{{- if hasKey $group "keys" -}}
{{- if gt (len $group.keys) 0 -}}
{{- printf `{{- $sharedSecrets := %s | split "\n" }}` ((join "\n" $group.keys) | quote) }}
{{- printf `{{- with secret %s }}` ($group.vaultPath | quote) }}
{{- printf `{{- range $k, $v := .Data.data }}`}}
{{- printf `{{- if in $sharedSecrets $k }}`}}
{{- printf `{{- scratch.MapSet "secrets" $k $v }}`}}
{{- printf `{{- end }}`}}
{{- printf `{{- end }}`}}
{{- printf `{{- end }}`}}
{{- end -}}
{{- end -}}
{{- end -}}
{{- end -}}
{{- end -}}
{{- end -}}
{{- printf `{{- with secret %s }}` (.Values.secrets.vaultPath | quote) }}
{{- printf `{{- range $k, $v := .Data.data }}`}}
{{- printf `{{- scratch.MapSet "secrets" $k $v }}`}}
{{- printf `{{- end }}`}}
{{- printf `{{- end }}`}}
{{- end -}}

{{/*
Generates Vault injection template value as JSON
*/}}
{{- define "dsre-charts-common.secret-template-json" -}}
{{- printf `{{- scratch.Get "secrets" | toJSONPretty }}`}}
{{- end -}}

{{/*
Generates Vault injection template value as Properties
*/}}
{{- define "dsre-charts-common.secret-template-props" -}}
{{- printf `{{- range $k, $v := scratch.Get "secrets" }}`}}
{{- printf `{{ $k }}={{ $v }}`}}
{{- printf `{{ "\n" }}`}}
{{- printf `{{- end -}}`}}
{{- end -}}

{{/*
Generates Vault injection template value as env
*/}}
{{- define "dsre-charts-common.secret-template-env" -}}
{{- printf `{{- range $k, $v := scratch.Get "secrets" }}`}}
{{- printf `export {{ $k }}={{ $v }}`}}
{{- printf `{{ "\n" }}`}}
{{- printf `{{- end -}}`}}
{{- end -}}

{{/*
Generates Vault injection template value as YAML
*/}}
{{- define "dsre-charts-common.secret-template-yaml" -}}
{{- printf `{{- scratch.Get "secrets" | toYAML }}`}}
{{- end -}}

{{/*
Generates Vault Deployment annotations
*/}}
{{- define "dsre-charts-common.vault-annotations" -}}
{{- if .Values.secrets.vaultPath }}
{{/*vault annotations*/}}
vault.hashicorp.com/auth-path: {{ .Values.secrets.kubernetesAuthPath | default "auth/kubernetes" | quote }}
vault.hashicorp.com/log-level: "warn"
vault.hashicorp.com/role: {{ .Values.secrets.vaultRole | quote }}
vault.hashicorp.com/namespace: {{ .Values.secrets.vaultNamespace | quote }}
{{/*vault injector annotations*/}}
vault.hashicorp.com/agent-inject: "true"
vault.hashicorp.com/agent-init-first : "true"
vault.hashicorp.com/agent-inject-status: "update"

{{ if eq (lower .Values.secrets.vaultSecretsFileType) "json" }}
vault.hashicorp.com/agent-inject-secret-config.json: {{ .Values.secrets.vaultPath | quote }}
vault.hashicorp.com/agent-inject-template-config.json: >
  {{ include "dsre-charts-common.secret-template-common" . }}
  {{ include "dsre-charts-common.secret-template-json" . }}
{{ else if eq (lower .Values.secrets.vaultSecretsFileType) "yaml" }}
vault.hashicorp.com/agent-inject-secret-config.yaml: {{ .Values.secrets.vaultPath | quote }}
vault.hashicorp.com/agent-inject-template-config.yaml: >
  {{ include "dsre-charts-common.secret-template-common" . }}
  {{ include "dsre-charts-common.secret-template-yaml" . }}
{{ else if eq (lower .Values.secrets.vaultSecretsFileType) "env" }}
{{- $conf := "/vault/secrets/env.conf" -}}
vault.hashicorp.com/agent-inject-secret-env.conf: {{ .Values.secrets.vaultPath | quote }}
vault.hashicorp.com/agent-inject-template-env.conf: >
  {{ include "dsre-charts-common.secret-template-common" . }}
  {{ include "dsre-charts-common.secret-template-env" . }}
{{ else if eq (lower .Values.secrets.vaultSecretsFileType) "props" }}
{{- $props := "/vault/secrets/config.properties" -}}
vault.hashicorp.com/agent-inject-secret-config.properties: {{ .Values.secrets.vaultPath | quote }}
vault.hashicorp.com/agent-inject-template-config.properties: >
  {{ include "dsre-charts-common.secret-template-common" . }}
  {{ include "dsre-charts-common.secret-template-props" . }}
{{- end -}}
{{- end }}
{{- end -}}