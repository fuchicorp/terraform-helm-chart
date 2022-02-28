variable "deployment_endpoint" {
  description = "-(Required) Endpoint for the application"
}

variable "deployment_name" {
  description = "-(Required) The name of the deployment"
}

variable "deployment_environment" {
  description = "-(Required) The name of the environment"
}

variable "deployment_path" {
  description = "-(Required) Chart location or chart name <stable/example>"
}

variable "release_version" {
  description = "-(Optional) Specify the exact chart version to install"
  default     = "0.1.0"
}

variable "override_values_file" {
  default     = "override-values.yaml"
  description = "-(Optional) file to be created to override and customize default remote helm chart values.yaml"
}

variable "remote_chart" {
  default = "false"
  description = "-(Optional) For the remote charts set to <true>"
}

variable "enabled" {
  default = "true"
  description = "-(Optional) deployment can be disabled or enabled by using this bool!"
}

variable "template_custom_vars" {
  type    = "map"
  default = {}
  description = "-(Optional) Local chart replace variables from values.yaml"
}

variable "env_vars" {
  type    = "map"
  default = {}
}

variable "trigger" {
  default = "UUID"
}

variable "timeout" {
  default = "400"
}

variable "recreate_pods" {
  default = false
}

variable "values" {
  default = "values.yaml"
  description = "-(Optional) Local chart <values.yaml> location"
}

variable "remote_override_values" {
  default = ""
  description = "-(Optional)"
}
