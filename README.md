## Terraform module helm-deploy

This terraform module will help you deploy the helm charts on local.

- [Requirements](#Requirements)

- [Usage](#usage)

- [Variables](#variables)

- [Custom variable deployment](#custom-variable-deployment)

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
    $ helm create charts/example

    Creating example

    $ ls charts/example

    Chart.yaml  charts      templates   values.yaml
    ```

2. After you created your helm chart you can go ahead and customize it by creating a file `override-values.yaml` ( its name should match the name declared in the `module.tf` ),where you can state the modifications wanted to override the default `values.yaml` based on your chart requirements and needs. 

3. Create `module.tf` to call the module on terraform registry

    ```
    cat <<EOF >module.tf
    module "helm_deploy" {
      source = "fuchicorp/chart/helm"
      version = "0.0.10"
      deployment_endpoint    = "example.domain.com"
      deployment_name        = "example-deployment-name"
      deployment_environment = "dev"
      deployment_path        = "./charts/example"      
      release_version = "2.19.0"
      override-values-file = "override-values.yaml"
      remote_chart = "true"
      enabled = "true"
    }
    EOF
    ```
4. Create a simple output file named `output.tf` and copy and paste the following:
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

For more info, please see the [variables file](variables.tf).

| Variable                 | Description                                                                                 | Default      | Type            |
| :----------------------- | :------------------------------------------------------------------------------------------ | :----------: | :-------------: |
| `deployment_endpoint`    | Ingress endpoint `example.fuchicorp.com`                                                    | `(Required)` | `domain/string` |
| `deployment_name`        | The name of the deployment for helm release                                                 | `(Required)` | `string`        |
| `deployment_environment` | Name of the namespace                                                                       | `(Required)` | `string`        |
| `deployment_path`        | path for helm chart on local                                                                | `(Required)` | `string`        |
| `release_version`        | Specify the exact chart version to install.                                                 | `(Required)` | `string`        |
| `override-values-file`   | Specify the name of the file to override default `values.yaml file`                         | `(Required)` | `string`        |
| `remote_chart`           | Specify whether to deploy remote_chart to `"true"` or `"false"` default value is `"false"`  | `(Required)` | `bool`          |
| `enabled`                | Specify if you want to deploy the enabled to `"true"` or `"false"` default value is `"true"`| `(Optional)` | `bool`          |
| `template_custom_vars`   | Template custom veriables you can modify variables by parsting the `template_custom_vars`   | `(Optional)` | `map`           |
| `env_vars`               | Environment veriable for the containers takes map                                           | `(Optional)` | `map`           |
| `timeout`                | If you would like to increase the timeout                                                   | `(Optional)` | `number`        |
| `recreate_pods`          | On update performs pods restart for the resource if applicable.                             | `(Optional)` | `bool`          |       
| `values`                 | Name of the values.yaml file                                                                | `(Optional)` | `string`        |



## Custom variable deployment 
In a case of local chart deployment, we can always use `template_custom_vars` to override some deployments specs

```
module "helm_deploy" {
  # source = "git::https://github.com/fuchicorp/helm-deploy.git"
  source                 = "fuchicorp/chart/helm"
  version                = "0.0.10"
  deployment_endpoint    = "jenkins.fuchicorp.com"
  deployment_name        = "test-jenkins"
  deployment_environment = "dev"
  deployment_path        = "jenkins/jenkins"
  release_version        = "2.19.0"
  override-values-file   = "override-values.yaml"
  remote_chart           = "false"
  enabled                = "true"
  template_custom_vars   = {
    deployment_image = "nginx"
  }
}
```

Every key and value you define inside `template_custom_vars` will be used for your `values.yaml`. 
In this case  --> `deployment_image` value will be replaced inside the file to `nginx` 

```
$ cat jenkins/jenkins/values.yaml | grep repository   
  repository: ${deployment_image}
```

Output file will be: 

```
$ cat .cache/values.yaml | grep reposit
  repository: nginx
```

You can see the `repository` replaced to the overritten value `nginx`

```
Thanks for using our chart,
Developed by FuchiCorp DevOps team, Enjoy using it! 
```
