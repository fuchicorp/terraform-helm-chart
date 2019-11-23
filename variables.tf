## The name of the deployment
variable "deployment_name" {
  description = "The name of the deployment"
}

## The name of the environment
variable "deployment_environment" {
  description = "The name of the environment"
}

## Chart location or chart name
variable "deployment_path" {
  description = "Chart location or chart name <stable/example>"
}

## Endpoint for the application
variable "deployment_endpoint" {
  description = "Endpoint for the application"
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
