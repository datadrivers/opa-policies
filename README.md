# opa-policies
This repository is a collection of open policy agent(OPA) policies

## Usage example

1. Add helm chart repository

    ```shell
    helm repo add opa-policies https://datadrivers.github.io/opa-policies
    helm repo update
    ```

2. Install  opa-policy chart

   ```shell 
    helm install probes-policy opa-policies/opa-constraint-template-probes
   ```

## Development

### test

```bash
opa test charts/*/opa -v
```
