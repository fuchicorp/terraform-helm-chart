locals {
  required_values = {
    # Deployment endpoint for ingress
    deployment_endpoint = lower(var.deployment_endpoint)

    # <deployment_name> for backend.tf and also release name
    deployment_name = lower(var.deployment_name)
  }

  # When all requred values all deffined then also will incloude users values
  template_all_values = merge(local.required_values, var.template_custom_vars)
  timeout             = var.timeout
  recreate_pods       = var.recreate_pods
}

# template_file.chart_values_template actual values.yaml file from charts
data "template_file" "local_chart_values_template" {
  count    = var.enabled == "true" && var.remote_chart == "false" ? 1 : 0
  template = file("${var.deployment_path}/${var.values}")
  vars     = local.template_all_values
}

locals {
  trigger = var.trigger == "UUID" ? uuid() : var.trigger
}



## helm_release.helm_deployment is actual helm deployment
resource "helm_release" "helm_local_deployment" {
  count         = var.enabled == "true" && var.remote_chart == "false" ? 1 : 0
  name          = var.deployment_name
  namespace     = var.deployment_environment
  chart         = var.deployment_path
  timeout       = local.timeout
  recreate_pods = local.recreate_pods
  version       = var.release_version

  values = [
    trimspace(data.template_file.local_chart_values_template.0.rendered),
  ]
}



resource "helm_release" "helm_remote_deployment" {
  count         = var.enabled == "true" && var.remote_chart == "true" ? 1 : 0
  name          = var.deployment_name
  namespace     = var.deployment_environment
  chart         = var.deployment_path
  timeout       = local.timeout
  recreate_pods = local.recreate_pods
  version       = var.release_version
  repository    = var.chart_repo

  values = [
    var.remote_override_values
  ]
}