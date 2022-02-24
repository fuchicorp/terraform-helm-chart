# Endpoint for the application
variable "deployment_endpoint" {
  description = "Endpoint for the application"
}

# The name of the deployment
variable "deployment_name" {
  description = "The name of the deployment"
}

# The name of the environment
variable "deployment_environment" {
  description = "The name of the environment"
}

# Chart location or chart name
variable "deployment_path" {
  description = "Chart location or chart name <stable/example>"
}

variable "release_version" {
  description = "(Required) Specify the exact chart version to install"
  default     = " 0.1.0"
}

# The name of the override-values-file file
variable "override-values-file" {
  default     = "override-values.yaml"
  description = "file to be created to override and customize default remote helm chart values.yaml"
}

variable "remote_chart" {
  default = "false"
}

variable "enabled" {
  default = "true"
}

variable "template_custom_vars" {
  type    = "map"
  default = {}
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
}

variable "overide_values" {
  type = "list"

  default = [
    "",
  ]
}
