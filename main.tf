################
### Provider ###
################

provider "google" {
  credentials = "${file("account.json")}"
  project     = "${var.project_id}"
  region      = "${var.region}"
  zone        = "${var.zone}"
}

resource "random_id" "instance_id" {
  byte_length = 8
}

###############
### NETWORK ###
###############

resource "google_compute_network" "network" {
  description             = "A VPC with a single access point (reverse proxy) that sends a balanced load to a managed instance group"
  name                    = "prjnetwork"
  auto_create_subnetworks = "true"
  routing_mode            = "REGIONAL"  
}

resource "google_compute_firewall" "firewall" {
  description = "The firewall ought to block all incoming traffic to every resource except for the reverse proxy. Traffic allowed to the reverse proxy is HTTP(S) and SSH"

  name = "prjfirewall"
  network = "${google_compute_network.network.self_link}"
  direction = "INGRESS"
  disabled = "false"
  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }
  target_tags = ["reverse-proxy-aka-point-of-entry"]
}
