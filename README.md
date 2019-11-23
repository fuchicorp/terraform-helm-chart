# Terraform module helm-deploy

This terraform module will help you deploy the helm charts on local.

- [Requirements](#Requirements)
- [Usage](#usage)
- [Variables](#variables)
- [Dependencies](#dependencies)
- [Links](#links)

## Requirements

Terraform >= 0.11.7

Kubernetes  >=  v1.14.8

Tiller >= v2.11.0

## Usage

```hcl
module "helm_deploy" {
  source                 = "git::https://github.com/fuchicorp/helm-deploy.git"
  deployment_name        = "artemis-deployment"
  deployment_environment = "dev"
  deployment_endpoint    = "artemis.fuchicorp.com"
  deployment_path        = "artemis"
  env_vars               = "${var.env_vars}"
}
```

## Variables

For more info, please see the [variables file](variables.tf).

| Variable               | Description                         | Default                                               |
| :--------------------- | :---------------------------------- | :---------------------------------------------------- |
| `deployment_name` | The name of the deployement for helm release | `(Required)` |
| `deployment_environment` | Name of the namespace | `(Required)` |
| `deployment_endpoint` | Ingress endpoint `example.fuchicorp.com` | `(Required)` |
| `deployment_path` | path for helm chart on local | `(Required)` |
| `env_vars` | Environment veriable for the containers takes map | `(Required)` |

## Dependencies

This module exposes two variables to work around the limitations of modules in Terraform.

| Name               | Type                         | Description                                     |
| :----------------- | :--------------------------- | :---------------------------------------------- |
| `depends_on` | `list variable` | Dummy variable to enable module dependencies. |
| `dependency` | `list output` | Dummy output to enable module dependencies. |
