terraform {
  required_version = ">= 0.13.7"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.5.1"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.2.3"
    }
    template = {
      source  = "hashicorp/template"
      version = "2.2.0"
    }
  }
}
