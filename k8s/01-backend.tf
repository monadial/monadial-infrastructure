terraform {
  required_providers {
    scaleway = {
      source = "scaleway/scaleway"
    }
     null = {
      source = "hashicorp/null"
    }
  }
  required_version = ">= 0.13"
}