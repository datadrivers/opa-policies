# opa-policies
This repository is a collection of open policy agent(OPA) policies

## Usage example

1. Add helm chart repository

    ```shell
    helm repo add opa-policies https://datadrivers.github.io/opa-policies
    helm repo update
    ```

2. Install template via opa-policy chart

    ```shell 
    helm install probes-policy opa-policies/opa-constraint-template-probes
    ```

3. Use opa constrainttemplate in dryrun mode

    ```shell
    kubectl apply -f - <<EOF
    apiVersion: constraints.gatekeeper.sh/v1beta1
    kind: ProbesPolicy
    metadata:
      name: probes-required
    spec:
      enforcementAction: dryrun
      match:
        kinds:
          - apiGroups: ["apps"]
            kinds: ["Deployment", "StatefulSet", "DaemonSet"]
          - apiGroups: ["batch"]
            kinds: ["Job", "CronJob"]
          - apiGroups: [""]
            kinds: ["Pod"]
        excludedNamespaces:
          - kube-system
      parameters:
        excludedDeployments: []
        excludedDaemonSets: []
        excludedStatefulSets: []
        excludedCronJobs: []
        excludedJobs: []
        excludedPods: []
    EOF
    ```

## Development

### test

```bash
opa test charts/*/opa -v
```
