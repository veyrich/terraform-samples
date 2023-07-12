#baseline config for newly created projects

terraform {
  required_version = ">= 1.5.1"
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


resource "google_org_policy_policy" "trusted_images" {
  name   = "projects/${var.project_name}/policies/compute.trustedImageProjects"
  parent = "projects/${var.project_name}"

  #allow specific image projects
  spec {
    rules {
      values {
        allowed_values = ["projects/debian-cloud", "projects/cloud-hpc-image-public"]
      }
    } #rules
  }   #spec

  #or turn off enforcement altogether
  #   spec {
  #     rules {
  #     #pick either?
  # #      allow_all = "FALSE"
  #       enforce = "FALSE"
  #     } #rules
  #   }   #spec
}
