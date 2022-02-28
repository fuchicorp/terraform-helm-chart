## Terraform module helm-deploy

This terraform module will help you deploy the helm charts on local.

- [Requirements](#Requirements)

- [Usage](#usage)

- [Variables](#variables)

- [Custom Remote Chart Deployment](#custom-remote-chart-deployment)

- [Custom Local Chart Deployment](#custom-local-chart-deployment)

## Requirements
1. Make sure that you have `kubectl` installed and you have configured your `~/.kube/config` 
2. Make sure that terraform also installed and follows Requirements

  * Kubernetes  >=  v1.14.8

  * Terraform >= 0.11.7


## Usage

1. First you will need to create your own helm chart, follow this [link](https://docs.bitnami.com/kubernetes/how-to/create-your-first-helm-chart/) for detailed instructions. If you would like to quickly create helm chart then run:

    ```
    $ mkdir -p deployments/terraform/charts  
    $ cd deployments/terraform

    #### for remote chart deployment ####
    find the remote charte you want to deploy then add the repo as follow:

    $ helm repo add example https://example.github.io/helm-charts
    $ helm repo update

    #### for local chart deployment ####
    $ helm create charts/example

    Creating example

    $ ls charts/example

    Chart.yaml  charts      templates   values.yaml


    ```

2. Create `module.tf` to call the module on terraform registry, then customize it under data section by stating your custom values as your chart needed.

    ```
    cat <<EOF >module.tf
    module "helm_deploy" {
      source                 = "fuchicorp/chart/helm"
      version                = "0.0.10"
      deployment_endpoint    = "example.domain.com"
      deployment_name        = "example-deployment-name"
      deployment_environment = "dev"
      deployment_path        = "example/example"      
      release_version        = "#example chart version"
      remote_chart           = "true"
      enabled                = "true"
      remote_override_values = "${data.template_file.deployment_values.rendered}"
    }

    data "template_file" "deployment_values" {
      template = <<EOF

    #put here your custom values like so:
    replicas: 2
    
    EOF
    }

    EOF
    ```

3. Create a simple output file named `output.tf` and copy and paste the following:
    ```
    output "success" {
      value = "${module.helm_deploy.success_output}"
    }
    ```


<br>Follow the file path:
```yaml
./module.tf
./output.tf
./charts/
  /example ## Your chart location 
    /Chart.yaml
    /charts
    /templates
    /values.yaml
```
<br><br>

## Variables

For more info, please see the [variables file](https://github.com/fuchicorp/terraform-helm-chart/blob/master/variables.tf).

| Variable                 | Description                                                                                 | Default      | Type            |
| :----------------------- | :------------------------------------------------------------------------------------------ | :----------: | :-------------: |
| `deployment_endpoint`    | Ingress endpoint `example.fuchicorp.com`                                                    | `(Required)` | `domain/string` |
| `deployment_name`        | The name of the deployment for helm release                                                 | `(Required)` | `string`        |
| `deployment_environment` | Name of the namespace                                                                       | `(Required)` | `string`        |
| `deployment_path`        | path for helm chart on local                                                                | `(Required)` | `string`        |
| `release_version`        | Specify the exact chart version to install.                                                 | `(Optional)` | `string`        |
| `remote_override_values` | Specify the name of the file to override default `values.yaml file`                         | `(Optional)` | `string`        |
| `remote_chart`           | Specify whether to deploy remote_chart to `"true"` or `"false"` default value is `"false"`  | `(Optional)` | `bool`          |
| `enabled`                | Specify if you want to deploy the enabled to `"true"` or `"false"` default value is `"true"`| `(Optional)` | `bool`          |
| `template_custom_vars`   | Template custom veriables you can modify variables by parsting the `template_custom_vars`   | `(Optional)` | `map`           |
| `env_vars`               | Environment veriable for the containers takes map                                           | `(Optional)` | `map`           |
| `timeout`                | If you would like to increase the timeout                                                   | `(Optional)` | `number`        |
| `recreate_pods`          | On update performs pods restart for the resource if applicable.                             | `(Optional)` | `bool`          |       
| `values`                 | Name of the values.yaml file                                                                | `(Optional)` | `string`        |



## Custom Remote Chart Deployment 
In a case of remote chart deployment, you can follow the above instruction and use the `module.tf` as follow:

```
  cat <<EOF >module.tf

  module "helm_deploy_remote" {
    source                 = "fuchicorp/chart/helm"
    version                = "0.0.10"
    deployment_endpoint    = "grafana.fuchicorp.com"
    deployment_name        = "grafana"
    deployment_environment = "dev"
    deployment_path        = "grafana/grafana"
    enabled                = "true"
    remote_chart           = "true"
    release_version        = "6.22.0"
    remote_override_values = "${data.template_file.deployment_values.rendered}"
  }

  data "template_file" "deployment_values" {
    template = <<EOF
  replicas: 4
  EOF
  }

  EOF
```
    

## Custom Local Chart Deployment 
In a case of local chart deployment, you can follow the above instruction and use the `module.tf` as follow: <br>
```
  cat <<EOF >module.tf

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

  EOF
```



## Thanks for using our chart, Enjoy using it! 
```
Developed by FuchiCorp DevOps team 🙂

```
