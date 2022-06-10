## Terraform module helm-deploy

This terraform module will help you deploy the helm charts on local.

- [Requirements](#requirements)

- [Usage remote chart](#usage-remote-chart)

- [Usage local chart](#usage-local-chart)

- [Example Remote Chart Deployment](#example-remote-chart-deployment )

- [Example Local Chart Deployment](#example-local-chart-deployment )

- [Variables](#variables)

## Requirements
1. Make sure that you have `kubectl` installed and you have configured your `~/.kube/config` 
2. Make sure that terraform also installed and follows requirements

  * Kubernetes  >=  v1.14.8

  * Terraform >= 0.13.7


## Usage remote chart

First you will need to find the proper helm chart from the https://artifacthub.io/
```
mkdir ~/example-deployment 
cd ~/example-deployment 
```

Create `module.tf` to call the module on terraform registry, then customize it under the data section by stating your custom values as your chart needed.

```hcl
module "helm_deploy" {
  source                 = "fuchicorp/chart/helm"
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
After you are done with all the custom configurations now you can go ahead and do the deployment
```sh
terraform init && terraform apply 
```

## Example Remote Chart Deployment 
In the case of remote chart deployment, you can follow the above instruction to deploy grafana 

```hcl
module "helm_deploy_remote" {
  source                 = "fuchicorp/chart/helm"
  deployment_name        = "grafana"
  deployment_environment = "dev"
  deployment_path        = "grafana/grafana"
  chart_repo             = "https://grafana.github.io/helm-charts"
  enabled                = "true"
  remote_chart           = "true"
  release_version        = "6.22.0"
  remote_override_values = <<EOF
## Grafana 
replicas: ${var.grafana_replicas}

## Ingress for the grafana
ingress:
  enabled: true
  annotations: {}
    # kubernetes.io/ingress.class: nginx
    # kubernetes.io/tls-acme: "true"
  hosts:
    - host: ${var.grafana_endpoint}
      paths:
      - '/'
  tls:
  - secretName: chart-example-tls
    hosts:
    - ${var.grafana_endpoint}
EOF 
}
```

You can go ahead and create `variables.tf` and use them to deploy the Grafana server into your Kubernetes Cluster
```
variable "grafana_endpoint" {
  default = "grafana.domain.com"
}

variable "grafana_replicas" {
  default = 1
}
```
    
## Example Local Chart Deployment 
In this example, you will learn how to use this module to deploy your local charts without packaging them. First, you will need to create your own local helm chart, to quickly do that, run 
```sh
mkdir -p ~/terraform/charts
cd ~/terraform/
```
Now you have the base folder and good to go ahead and create your local chart
```sh
helm create charts/my-example-chart
```

## Usage local chart
Create `module.tf` file to call the module on terraform registry then customize it as needed.

```hcl
module "helm_deploy_local" {
  source                 = "fuchicorp/chart/helm"
  deployment_name        = "my-example-chart"                 ## Name of the local chart 
  deployment_environment = "dev"                              ## Kubernetes Namespace
  deployment_path        = "charts/my-example-chart"          ## Deployment path name
  remote_chart           = "false"                            ## Set to false to remote chart true to local charts
  enabled                = "true"                             ## Enable to deploy the local chart
  template_custom_vars   = {
    deployment_endpoint  = "my-example-chart.domain.com"
    deployment_image     = "nginx"
    deployment_image_tag = "latest"
  }
}

```

Once you have the default local helm chart you can go ahead and create and use variables from terraform inside your `values.yaml`
```
image:
  repository: ${deployment_image}
  pullPolicy: IfNotPresent
  # Overrides the image tag whose default is the chart appVersion.
  tag: ${deployment_image_tag}

ingress:
  enabled: true
  annotations: {}
    # kubernetes.io/ingress.class: nginx
    # kubernetes.io/tls-acme: "true"
  hosts:
    - host: ${deployment_endpoint}
      paths: []
  tls:
  - secretName: chart-example-tls
    hosts:
    - ${deployment_endpoint}
```

Now its time to initialize the terraform and deploy it 
```
terraform init && terraform apply 
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
This terraform module developed by the FuchiCorp LLC DevOps team. Thanks for using our chart, Enjoy using it! 
