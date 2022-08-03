variable "deployment_endpoint" {
  description = "-(Optional) Endpoint for the application"
  default     = "example.local"
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

variable "remote_chart" {
  type        = bool
  default     = false
  description = "-(Optional) For the remote charts set to <true>"
}

variable "enabled" {
  type        = bool
  default     = true
  description = "-(Optional) deployment can be disabled or enabled by using this bool!"
}

variable "template_custom_vars" {
  type        = map
  default     = {}
  description = "-(Optional) Local chart replace variables from values.yaml"
}

variable "trigger" {
  default = "UUID"
}

variable "timeout" {
  default = "400"
}

variable "recreate_pods" {
  type        = bool
  default     = false
}

variable "values" {
  default     = "values.yaml"
  description = "-(Optional) Local chart <values.yaml> location"
}

variable "remote_override_values" {
  default     = ""
  description = "-(Optional)"
}

variable "chart_repo" {
  default     = ""
  description = "-(Optional) Provide the remote helm charts repository."
}

