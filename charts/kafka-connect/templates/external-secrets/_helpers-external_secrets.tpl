{{/*
Expand the name of the chart.
*/}}
{{- define "dsre-charts-common.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
External Secrets annotations
*/}}
{{- define "dsre-charts-common.external-secrets-annotations" -}}
helm.sh/hook: pre-upgrade,pre-install,pre-rollback
helm.sh/hook-weight: "-1"
{{- end -}}

{{/*
Docker Credentials
*/}}
{{- define "dsre-charts-common.dockerhub-creds" -}}
.dockerconfigjson: |
    {
      "auths": {
        "https://index.docker.io/v1/": {
          "username": {{`"{{ .username }}"`}},
          "password": {{`"{{ .password }}"`}},
          "email": {{`"{{ .email }}"`}},
          "auth": {{`"{{ list .username .password | join ":" | b64enc }}"`}}
        }
      }
    }
{{- end -}}

{{- define "dsre-charts-common.dockerhub-creds-data" -}}
- secretKey: username
  remoteRef:
    key: kv-v2-dsre/dim_docker_creds
    property: username
- secretKey: password
  remoteRef:
    key: kv-v2-dsre/dim_docker_creds
    property: password 
- secretKey: email
  remoteRef:
    key: kv-v2-dsre/dim_docker_creds
    property: email  
{{- end -}}
    
{{/*
Jfrog Credentials
*/}}
{{- define "dsre-charts-common.jfrog-creds" -}}
.dockerconfigjson: |
    {
      "auths": {
        "https://index.docker.io/v1/": {
          "username": {{`"{{ .username }}"`}},
          "password": {{`"{{ .password }}"`}},
          "email": {{`"{{ .email }}"`}},
          "auth": {{`"{{ list .username .password | join ":" | b64enc }}"`}}
        }
      }
    }
{{- end -}}

{{- define "dsre-charts-common.jfrog-creds-data" -}}
- secretKey: username
  remoteRef:
    key: kv-v2-dsre/dim_jfrog_creds
    property: username
- secretKey: password
  remoteRef:
    key: kv-v2-dsre/dim_jfrog_creds
    property: password 
- secretKey: email
  remoteRef:
    key: kv-v2-dsre/dim_jfrog_creds
    property: email  
{{- end -}}        


{{/*
SSH Credentials
*/}}
{{- define "dsre-charts-common.ssh-creds" -}}
template:
  type: kubernetes.io/ssh-auth
  data:
    ssh-privatekey: {{`"{{ .privatekey }}"`}}
    ssh-publickey: {{`"{{ .publickey }}"`}}
{{- end -}}


{{/*
TLS  Credentials
*/}}
{{- define "dsre-charts-common.tls-creds" -}}
template:
  type: kubernetes.io/tls
  data:   
    tls.crt: {{`"{{ .tls.crt }}"`}}
    tls.key: {{`"{{ .tls.key }}"`}}
{{- end -}}
