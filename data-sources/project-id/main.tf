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

data "google_project" "project" {
}
