# KubeInfinite cluster-autoscaler

Scales Kubernetes worker nodes within autoscaling groups.

## TL;DR

```console
$ helm repo add autoscaler https://github.com/thisurawijesekera/helm-chart-registry

# Method 1 - Using Autodiscovery
$ helm install my-release autoscaler/cluster-autoscaler \
    --set 'autoDiscovery.clusterName'=<CLUSTER NAME>

# Method 2 - Specifying groups manually
$ helm install my-release autoscaler/cluster-autoscaler \
    --set "autoscalingGroups[0].name=your-asg-name" \
    --set "autoscalingGroups[0].maxSize=10" \
    --set "autoscalingGroups[0].minSize=1"
```
