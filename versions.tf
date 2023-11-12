terraform {
  required_version = ">= 0.13.7"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.5.1"
    }
  }
}
