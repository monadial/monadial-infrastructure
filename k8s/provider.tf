variable "scaleway_access_key" {
  type        = string
  description = "Scaleway access key."
}

variable "scaleway_secret_key" {
  type        = string
  description = "Scaleway secret key."
}

variable "scaleway_project_id" {
  type        = string
  description = "Scaleway project id."
}

provider "scaleway" {
  access_key = var.scaleway_access_key
  secret_key = var.scaleway_secret_key
  project_id = var.scaleway_project_id
  region     = "nl-ams"
  zone       = "nl-ams-1"
}