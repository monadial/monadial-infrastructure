variable "scaleway_access_key" {
  type        = string
  description = "Scaleway access key."
}

variable "scaleway_secret_key" {
  type        = string
  description = "Scaleway secret key."
}

provider "scaleway" {
  access_key = var.scaleway_access_key
  secret_key = var.scaleway_secret_key
  project_id = "default"
  region     = "nl-ams"
  zone       = "nl-ams-1"
}