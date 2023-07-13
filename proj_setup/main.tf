#baseline config for newly created projects

terraform {
  required_version = ">= 1.5.2"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.72.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.gcp_region
}
#enable required APIs
module "apis" {
  source = "./modules/apis"
  apis = ["compute.googleapis.com",
  "orgpolicy.googleapis.com"]
  project_id = var.project_id
}

#create default VPC
module "vpc" {
  source = "./modules/vpc"
  #explicit dependcy on Compute Engine API
  depends_on = [module.apis]
}

#NAT router / gateway
module "nat" {
  source       = "./modules/nat"
  network_name = "default"
  depends_on   = [module.vpc]
}
