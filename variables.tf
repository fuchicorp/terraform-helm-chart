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
 variable "release_version" {
   description = "(Required) Specify the exact chart version to install"
   default     = " 0.1.0"
  
 }


 variable "remote_chart" {
   default     = "false"
 }
 
variable "values" {
   default     = "values.yaml"
 }
 