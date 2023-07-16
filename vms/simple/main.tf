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

resource "google_compute_instance" "simple" {
  name         = "e2-micro"
  machine_type = "e2-micro"
  zone         = var.gcp_zone

  #create a VM for testing but don't turn it on
  #NB: despite what the docs state, TF will only accept "RUNNING"
  #desired_status = "TERMINATED"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network    = "default"
    subnetwork = "default"
    #omit access_config to omit external IP address
    #access_config = {}
  }

      shielded_instance_config {
      enable_secure_boot = true
    }
}
