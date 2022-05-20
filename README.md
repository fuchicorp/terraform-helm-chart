## Terraform module helm-deploy

This terraform module will help you deploy the helm charts on local.

- [Requirements](#Requirements)

- [Usage remote chart](#usage-remote-chart)

- [Custom Remote Chart Deployment](#custom-remote-chart-deployment)

- [Custom Local Chart Deployment](#custom-local-chart-deployment)

- [Variables](#variables)

## Requirements
1. Make sure that you have `kubectl` installed and you have configured your `~/.kube/config` 
2. Make sure that terraform also installed and follows Requirements

  * Kubernetes  >=  v1.14.8

  * Terraform >= 0.11.7


## Usage remote chart

1. First you will need to find the proper helm chart from the https://artifacthub.io/
```
mkdir ~/example-deployment 
cd ~/example-deployment 
```

2. Create `module.tf` to call the module on terraform registry, then customize it under data section by stating your custom values as your chart needed.

```
module "helm_deploy" {
  source                 = "fuchicorp/chart/helm"
  version                = "0.0.10"
  remote_chart           = "true"                             ## Set to true to remote chart false to local charts
  chart_repo             = "https://github.io/helm-charts"    ## Here provide the repository url 
  enabled                = "true"                             ## Enable to deploy the chart
  deployment_name        = "example-deployment-name"          ## Release name in the namespace
  deployment_environment = "dev"                              ## Kubernetes Namespace
  deployment_path        = "example-remote-name"              ## Name of the remote chart 
  release_version        = "#example chart version"           ## Helm chart version 
  
  ## Your custom values.yaml
  remote_override_values = <<EOF
## Put here your custom values like to override the values.yaml
replicas: 2
EOF 
}

```
3. After you are done with all the custom configurations now you can go ahead do the deployment
```
terraform init
terraform apply
```
## Exmaple Remote Chart Deployment 
In a case of remote chart deployment, you can follow the above instruction to deploy grafana 

```
module "helm_deploy_remote" {
  source                 = "fuchicorp/chart/helm"
  version                = "0.0.10"
  deployment_name        = "grafana"
  deployment_environment = "dev"
  deployment_path        = "grafana/grafana"
  chart_repo             = "https://grafana.github.io/helm-charts"
  enabled                = "true"
  remote_chart           = "true"
  release_version        = "6.22.0"
  remote_override_values = <<EOF
## Grafana 
replicas: 4
EOF 
}
```
    
## Example Local Chart Deployment 
In a case of local chart deployment, 

1. First you will need to create your own local helm chart, to quickly do that, run 
```
mkdir -p ~/terraform/charts  
cd ~/terraform/charts  
```
Now you have base folder and good to go ahead and create your local chart
```
helm create my-example-chart
ls my-example-chart
# Chart.yaml    charts    templates   values.yaml
```
2. Then, Create `module.tf` file to call the module on terraform registry, then customize it as needed.

```
module "helm_deploy_local" {
  # source = "git::https://github.com/fuchicorp/helm-deploy.git"
  source                 = "fuchicorp/chart/helm"
  version                = "0.0.10"
  deployment_endpoint    = "berbers.fuchicorp.com"
  deployment_name        = "berbers"
  deployment_environment = "dev"
  deployment_path        = "charts/berbers"
  remote_chart           = "false"
  enabled                = "true"
}
```


## Variables

For more info, please see the [variables file](https://github.com/fuchicorp/terraform-helm-chart/blob/master/variables.tf).

| Variable                 | Description                                                                                 | Default      | Type            |
| :----------------------- | :------------------------------------------------------------------------------------------ | :----------: | :-------------: |
| `deployment_endpoint`    | Ingress endpoint `example.fuchicorp.com`                                                    | `(Optional)` | `domain/string` |
| `deployment_name`        | The name of the deployment for helm release                                                 | `(Required)` | `string`        |
| `deployment_environment` | Name of the namespace                                                                       | `(Required)` | `string`        |
| `deployment_path`        | path for helm chart on local                                                                | `(Required)` | `string`        |
| `release_version`        | Specify the exact chart version to install.                                                 | `(Optional)` | `string`        |
| `remote_override_values` | Specify the name of the file to override default `values.yaml file`                         | `(Optional)` | `string`        |
| `chart_repo`             | Url of the repository for the helm charts                                                   | `(Optional)` | `string`        |
| `remote_chart`           | Specify whether to deploy remote_chart to `"true"` or `"false"` default value is `"false"`  | `(Optional)` | `bool`          |
| `enabled`                | Specify if you want to deploy the enabled to `"true"` or `"false"` default value is `"true"`| `(Optional)` | `bool`          |
| `template_custom_vars`   | Template custom veriables you can modify variables by parsting the `template_custom_vars`   | `(Optional)` | `map`           |
| `env_vars`               | Environment veriable for the containers takes map                                           | `(Optional)` | `map`           |
| `timeout`                | If you would like to increase the timeout                                                   | `(Optional)` | `number`        |
| `recreate_pods`          | On update performs pods restart for the resource if applicable.                             | `(Optional)` | `bool`          |       
| `values`                 | Name of the values.yaml file                                                                | `(Optional)` | `string`        |


## Contribute
Request a feature at: https://github.com/fuchicorp/terraform-helm-chart/issues Fork and create PR

## Owner
This terraform module developed by FuchiCorp DevOps team. Thanks for using our chart, Enjoy using it! 
