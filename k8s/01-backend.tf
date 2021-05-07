terraform {
  required_providers {
    scaleway = {
      source = "scaleway/scaleway"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    helm = {
      source = "hashicorp/helm"
    }
  }
  required_version = ">= 0.13"
}