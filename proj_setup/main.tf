#create a new project (incl. custom network and adjusted org policices)

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

#create the project
resource "google_project" "this_project" {
  name                = var.project_name
  project_id          = var.project_id
  billing_account     = var.billing_account
  auto_create_network = false
  skip_delete         = false
}

#enable required APIs
module "apis" {
  source = "./modules/apis"
  apis = ["compute.googleapis.com",
  "orgpolicy.googleapis.com"]
  project_id = var.project_id
  #attempt to wait until the project is fully created
  #and the billing account has been set up
  depends_on = [google_project.this_project]
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

resource "google_org_policy_policy" "trusted_images" {
  name   = "projects/${var.project_name}/policies/compute.trustedImageProjects"
  parent = "projects/${var.project_name}"

  spec {
    rules {
      allow_all = "TRUE"
    }
  }
  depends_on = [module.nat]
}

resource "google_org_policy_policy" "shielded_vm" {
  name   = "projects/${var.project_name}/policies/compute.requireShieldedVm"
  parent = "projects/${var.project_name}"

  spec {
    rules {
      enforce = "FALSE"
    }
  }
  depends_on = [module.nat]
}

