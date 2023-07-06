#create default VPC (in custom mode to enable Google Private Access)
resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_network_name
  auto_create_subnetworks = false
}

#create a subnet
resource "google_compute_subnetwork" "vpc_subnetwork" {
  name = "default"
  network = google_compute_network.vpc_network.name
  region = var.vpc_subnetwork_region
  ip_cidr_range = var.vpc_ip_cidr_range 
  private_ip_google_access = var.vpc_google_private_access
}

#IAP setup
#add firewall rule
resource "google_compute_firewall" "fw_rule_iap" {
  name          = "iap-fw"
  network       = google_compute_network.vpc_network.name
  direction     = "INGRESS"
  source_ranges = ["35.235.240.0/20"]
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}
 