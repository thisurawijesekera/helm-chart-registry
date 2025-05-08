# cluster-autoscaler

![Version: 0.0.1](https://img.shields.io/badge/Version-0.0.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.0.1](https://img.shields.io/badge/AppVersion-0.0.1-informational?style=flat-square)

Scales Kubernetes worker nodes within autoscaling groups.

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| TS | <thisurawijesekera@gmail.com> |  |

## Source Code

* <https://github.com/thisurawijesekera/helm-chart-registry/tree/master/charts/cluster-autoscaler>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalLabels | object | `{}` | Labels to add to each object of the chart. |
| affinity | object | `{}` | Affinity for pod assignment |
| autoDiscovery.clusterName | string | `nil` | Enable autodiscovery for `cloudProvider=aws`, for groups matching `autoDiscovery.tags`. autoDiscovery.clusterName -- Enable autodiscovery for `cloudProvider=azure`, using tags defined in https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/cloudprovider/azure/README.md#auto-discovery-setup. Enable autodiscovery for `cloudProvider=clusterapi`, for groups matching `autoDiscovery.labels`. Enable autodiscovery for `cloudProvider=gce`, but no MIG tagging required. Enable autodiscovery for `cloudProvider=magnum`, for groups matching `autoDiscovery.roles`. |
| autoDiscovery.labels | list | `[]` | Cluster-API labels to match  https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/cloudprovider/clusterapi/README.md#configuring-node-group-auto-discovery |
| autoDiscovery.namespace | string | `nil` | Enable autodiscovery via cluster namespace for for `cloudProvider=clusterapi` |
| autoDiscovery.roles | list | `["worker"]` | Magnum node group roles to match. |
| autoDiscovery.tags | list | `["k8s.io/cluster-autoscaler/enabled","k8s.io/cluster-autoscaler/{{ .Values.autoDiscovery.clusterName }}"]` | ASG tags to match, run through `tpl`. |
| autoscalingGroups | list | `[]` | For AWS, Azure AKS, Exoscale or Magnum. At least one element is required if not using `autoDiscovery`. For example: <pre> - name: asg1<br />   maxSize: 2<br />   minSize: 1 </pre> For Hetzner Cloud, the `instanceType` and `region` keys are also required. <pre> - name: mypool<br />   maxSize: 2<br />   minSize: 1<br />   instanceType: CPX21<br />   region: FSN1 </pre> |
| autoscalingGroupsnamePrefix | list | `[]` | For GCE. At least one element is required if not using `autoDiscovery`. For example: <pre> - name: ig01<br />   maxSize: 10<br />   minSize: 0 </pre> |
| awsAccessKeyID | string | `""` | AWS access key ID ([if AWS user keys used](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/cloudprovider/aws/README.md#using-aws-credentials)) |
| awsRegion | string | `""` | AWS region (required if `cloudProvider=aws`) |
| awsSecretAccessKey | string | `""` | AWS access secret key ([if AWS user keys used](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/cloudprovider/aws/README.md#using-aws-credentials)) |
| azureClientID | string | `""` | Service Principal ClientID with contributor permission to Cluster and Node ResourceGroup. Required if `cloudProvider=azure` |
| azureClientSecret | string | `""` | Service Principal ClientSecret with contributor permission to Cluster and Node ResourceGroup. Required if `cloudProvider=azure` |
| azureEnableForceDelete | bool | `false` | Whether to force delete VMs or VMSS instances when scaling down. |
| azureResourceGroup | string | `""` | Azure resource group that the cluster is located. Required if `cloudProvider=azure` |
| azureSubscriptionID | string | `""` | Azure subscription where the resources are located. Required if `cloudProvider=azure` |
| azureTenantID | string | `""` | Azure tenant where the resources are located. Required if `cloudProvider=azure` |
| azureUseManagedIdentityExtension | bool | `false` | Whether to use Azure's managed identity extension for credentials. If using MSI, ensure subscription ID, resource group, and azure AKS cluster name are set. You can only use one authentication method at a time, either azureUseWorkloadIdentityExtension or azureUseManagedIdentityExtension should be set. |
| azureUseWorkloadIdentityExtension | bool | `false` | Whether to use Azure's workload identity extension for credentials. See the project here: https://github.com/Azure/azure-workload-identity for more details. You can only use one authentication method at a time, either azureUseWorkloadIdentityExtension or azureUseManagedIdentityExtension should be set. |
| azureUserAssignedIdentityID | string | `""` | When vmss has multiple user assigned identity assigned, azureUserAssignedIdentityID specifies which identity to be used |
| azureVMType | string | `"vmss"` | Azure VM type. |
| civoApiKey | string | `""` | API key for the Civo API. Required if `cloudProvider=civo` |
| civoApiUrl | string | `"https://api.civo.com"` | URL for the Civo API. Required if `cloudProvider=civo` |
| civoClusterID | string | `""` | Cluster ID for the Civo cluster. Required if `cloudProvider=civo` |
| civoRegion | string | `""` | Region for the Civo cluster. Required if `cloudProvider=civo` |
| cloudConfigPath | string | `""` | Configuration file for cloud provider. |
| cloudProvider | string | `"aws"` | The cloud provider where the autoscaler runs. Currently only `gce`, `aws`, `azure`, `magnum`, `clusterapi` and `civo` are supported. `aws` supported for AWS. `gce` for GCE. `azure` for Azure AKS. `magnum` for OpenStack Magnum, `clusterapi` for Cluster API. `civo` for Civo Cloud. |
| clusterAPICloudConfigPath | string | `"/etc/kubernetes/mgmt-kubeconfig"` | Path to kubeconfig for connecting to Cluster API Management Cluster, only used if `clusterAPIMode=kubeconfig-kubeconfig or incluster-kubeconfig` |
| clusterAPIConfigMapsNamespace | string | `""` | Namespace on the workload cluster to store Leader election and status configmaps |
| clusterAPIKubeconfigSecret | string | `""` | Secret containing kubeconfig for connecting to Cluster API managed workloadcluster Required if `cloudProvider=clusterapi` and `clusterAPIMode=kubeconfig-kubeconfig,kubeconfig-incluster or incluster-kubeconfig` |
| clusterAPIMode | string | `"incluster-incluster"` | Cluster API mode, see https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/cloudprovider/clusterapi/README.md#connecting-cluster-autoscaler-to-cluster-api-management-and-workload-clusters Syntax: workloadClusterMode-ManagementClusterMode for `kubeconfig-kubeconfig`, `incluster-kubeconfig` and `single-kubeconfig` you always must mount the external kubeconfig using either `extraVolumeSecrets` or `extraMounts` and `extraVolumes` if you dont set `clusterAPIKubeconfigSecret`and thus use an in-cluster config or want to use a non capi generated kubeconfig you must do so for the workload kubeconfig as well |
| clusterAPIWorkloadKubeconfigPath | string | `"/etc/kubernetes/value"` | Path to kubeconfig for connecting to Cluster API managed workloadcluster, only used if `clusterAPIMode=kubeconfig-kubeconfig or kubeconfig-incluster` |
| containerSecurityContext | object | `{}` | [Security context for container](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/) |
| customArgs | list | `[]` | Additional custom container arguments. Refer to https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md#what-are-the-parameters-to-ca for the full list of cluster autoscaler parameters and their default values. List of arguments as strings. |
| deployment.annotations | object | `{}` | Annotations to add to the Deployment object. |
| dnsPolicy | string | `"ClusterFirst"` | Defaults to `ClusterFirst`. Valid values are: `ClusterFirstWithHostNet`, `ClusterFirst`, `Default` or `None`. If autoscaler does not depend on cluster DNS, recommended to set this to `Default`. |
| envFromConfigMap | string | `""` | ConfigMap name to use as envFrom. |
| envFromSecret | string | `""` | Secret name to use as envFrom. |
| expanderPriorities | object | `{}` | The expanderPriorities is used if `extraArgs.expander` contains `priority` and expanderPriorities is also set with the priorities. If `extraArgs.expander` contains `priority`, then expanderPriorities is used to define cluster-autoscaler-priority-expander priorities. See: https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/expander/priority/readme.md |
| extraArgs | object | `{"logtostderr":true,"stderrthreshold":"info","v":4}` | Additional container arguments. Refer to https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md#what-are-the-parameters-to-ca for the full list of cluster autoscaler parameters and their default values. Everything after the first _ will be ignored allowing the use of multi-string arguments. |
| extraEnv | object | `{}` | Additional container environment variables. |
| extraEnvConfigMaps | object | `{}` | Additional container environment variables from ConfigMaps. |
| extraEnvSecrets | object | `{}` | Additional container environment variables from Secrets. |
| extraObjects | list | `[]` | Extra K8s manifests to deploy |
| extraVolumeMounts | list | `[]` | Additional volumes to mount. |
| extraVolumeSecrets | object | `{}` | Additional volumes to mount from Secrets. |
| extraVolumes | list | `[]` | Additional volumes. |
| fullnameOverride | string | `""` | String to fully override `cluster-autoscaler.fullname` template. |
| hostNetwork | bool | `false` | Whether to expose network interfaces of the host machine to pods. |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| image.pullSecrets | list | `[]` | Image pull secrets |
| image.repository | string | `"registry.k8s.io/autoscaling/cluster-autoscaler"` | Image repository |
| image.tag | string | `"v1.32.0"` | Image tag |
| initContainers | list | `[]` | Any additional init containers. |
| kubeTargetVersionOverride | string | `""` | Allow overriding the `.Capabilities.KubeVersion.GitVersion` check. Useful for `helm template` commands. |
| kwokConfigMapName | string | `"kwok-provider-config"` | configmap for configuring kwok provider |
| magnumCABundlePath | string | `"/etc/kubernetes/ca-bundle.crt"` | Path to the host's CA bundle, from `ca-file` in the cloud-config file. |
| magnumClusterName | string | `""` | Cluster name or ID in Magnum. Required if `cloudProvider=magnum` and not setting `autoDiscovery.clusterName`. |
| nameOverride | string | `""` | String to partially override `cluster-autoscaler.fullname` template (will maintain the release name) |
| nodeSelector | object | `{}` | Node labels for pod assignment. Ref: https://kubernetes.io/docs/user-guide/node-selection/. |
| podAnnotations | object | `{}` | Annotations to add to each pod. |
| podDisruptionBudget | object | `{"maxUnavailable":1}` | Pod disruption budget. |
| podLabels | object | `{}` | Labels to add to each pod. |
| priorityClassName | string | `"system-cluster-critical"` | priorityClassName |
| priorityConfigMapAnnotations | object | `{}` | Annotations to add to `cluster-autoscaler-priority-expander` ConfigMap. |
| prometheusRule.additionalLabels | object | `{}` | Additional labels to be set in metadata. |
| prometheusRule.enabled | bool | `false` | If true, creates a Prometheus Operator PrometheusRule. |
| prometheusRule.interval | string | `nil` | How often rules in the group are evaluated (falls back to `global.evaluation_interval` if not set). |
| prometheusRule.namespace | string | `"monitoring"` | Namespace which Prometheus is running in. |
| prometheusRule.rules | list | `[]` | Rules spec template (see https://github.com/prometheus-operator/prometheus-operator/blob/master/Documentation/api.md#rule). |
| rbac.clusterScoped | bool | `true` | if set to false will only provision RBAC to alter resources in the current namespace. Most useful for Cluster-API |
| rbac.create | bool | `true` | If `true`, create and use RBAC resources. |
| rbac.pspEnabled | bool | `false` | If `true`, creates and uses RBAC resources required in the cluster with [Pod Security Policies](https://kubernetes.io/docs/concepts/policy/pod-security-policy/) enabled. Must be used with `rbac.create` set to `true`. |
| rbac.serviceAccount.annotations | object | `{}` | Additional Service Account annotations. |
| rbac.serviceAccount.automountServiceAccountToken | bool | `true` | Automount API credentials for a Service Account. |
| rbac.serviceAccount.create | bool | `true` | If `true` and `rbac.create` is also true, a Service Account will be created. |
| rbac.serviceAccount.name | string | `""` | The name of the ServiceAccount to use. If not set and create is `true`, a name is generated using the fullname template. |
| replicaCount | int | `1` | Desired number of pods |
| resources | object | `{}` | Pod resource requests and limits. |
| revisionHistoryLimit | int | `10` | The number of revisions to keep. |
| secretKeyRefNameOverride | string | `""` | Overrides the name of the Secret to use when loading the secretKeyRef for AWS, Azure and Civo env variables |
| securityContext | object | `{}` | [Security context for pod](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/) |
| service.annotations | object | `{}` | Annotations to add to service |
| service.clusterIP | string | `""` | IP address to assign to service |
| service.create | bool | `true` | If `true`, a Service will be created. |
| service.externalIPs | list | `[]` | List of IP addresses at which the service is available. Ref: https://kubernetes.io/docs/concepts/services-networking/service/#external-ips. |
| service.labels | object | `{}` | Labels to add to service |
| service.loadBalancerIP | string | `""` | IP address to assign to load balancer (if supported). |
| service.loadBalancerSourceRanges | list | `[]` | List of IP CIDRs allowed access to load balancer (if supported). |
| service.portName | string | `"http"` | Name for service port. |
| service.servicePort | int | `8085` | Service port to expose. |
| service.type | string | `"ClusterIP"` | Type of service to create. |
| serviceMonitor.annotations | object | `{}` | Annotations to add to service monitor |
| serviceMonitor.enabled | bool | `false` | If true, creates a Prometheus Operator ServiceMonitor. |
| serviceMonitor.interval | string | `"10s"` | Interval that Prometheus scrapes Cluster Autoscaler metrics. |
| serviceMonitor.metricRelabelings | object | `{}` | MetricRelabelConfigs to apply to samples before ingestion. |
| serviceMonitor.namespace | string | `"monitoring"` | Namespace which Prometheus is running in. |
| serviceMonitor.path | string | `"/metrics"` | The path to scrape for metrics; autoscaler exposes `/metrics` (this is standard) |
| serviceMonitor.relabelings | object | `{}` | RelabelConfigs to apply to metrics before scraping. |
| serviceMonitor.selector | object | `{"release":"prometheus-operator"}` | Default to kube-prometheus install (CoreOS recommended), but should be set according to Prometheus install. |
| tolerations | list | `[]` | List of node taints to tolerate (requires Kubernetes >= 1.6). |
| topologySpreadConstraints | list | `[]` | You can use topology spread constraints to control how Pods are spread across your cluster among failure-domains such as regions, zones, nodes, and other user-defined topology domains. (requires Kubernetes >= 1.19). |
| updateStrategy | object | `{}` | [Deployment update strategy](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#strategy) |
| vpa | object | `{"containerPolicy":{},"enabled":false,"updateMode":"Auto"}` | Configure a VerticalPodAutoscaler for the cluster-autoscaler Deployment. |
| vpa.containerPolicy | object | `{}` | [ContainerResourcePolicy](https://github.com/kubernetes/autoscaler/blob/vertical-pod-autoscaler/v0.13.0/vertical-pod-autoscaler/pkg/apis/autoscaling.k8s.io/v1/types.go#L159). The containerName is always et to the deployment's container name. This value is required if VPA is enabled. |
| vpa.enabled | bool | `false` | If true, creates a VerticalPodAutoscaler. |
| vpa.updateMode | string | `"Auto"` | [UpdateMode](https://github.com/kubernetes/autoscaler/blob/vertical-pod-autoscaler/v0.13.0/vertical-pod-autoscaler/pkg/apis/autoscaling.k8s.io/v1/types.go#L124) |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.3](https://github.com/norwoodj/helm-docs/releases/v1.11.3)
