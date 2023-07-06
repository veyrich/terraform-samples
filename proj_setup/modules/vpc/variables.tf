variable "vpc_network_name" {
  type    = string
  default = "default"
}

variable "vpc_subnetwork_region" {
  type    = string
  default = "us-central1"
}

variable "vpc_ip_cidr_range" {
  type = string
  default = "10.1.0.0/22"
}

variable "vpc_google_private_access" {
  type = bool
  default = true
}


