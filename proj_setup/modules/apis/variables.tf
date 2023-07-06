variable "project_id" {
  type = string
}

variable "gcp_region" {
  type    = string
  default = "us-central1"
}

variable "apis" {
  type = list(string)
  default = ["compute.googleapis.com"]
}
