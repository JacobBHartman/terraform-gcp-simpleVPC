resource "google_compute_instance" "reverse-proxy" {
  name         = "reverse-proxy"
  machine_type = "f1-micro"
  zone         = "${var.zone}"

  tags = ["reverse-proxy-aka-point-of-entry"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "${google_compute_network.network.self_link}"
    access_config {
      // Ephemeral IP
    }
  }

  metadata_startup_script = "sudo-apt-get update; sudo apt-get install -yq nginx; sudo echo 'Howdy' >> /var/www/html/index.html"

  metadata { 
    sshKeys = "joh:${file("~/.ssh/id_rsa.pub")}"
  }  
}
