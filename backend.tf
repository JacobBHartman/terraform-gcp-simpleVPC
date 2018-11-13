/**
 * Project Name: "proj"
 * Description : "This page contains the backend components for a VPC"
 * Resources   : google_compute_instance_group_manager
 *               google_compute_health_check
 *               google_compute_instance_template
 *               google_compute_image
 * Author      : Jacob Hartman
 */ 


/**
 * A managed instance group serving the app with a companion health check
 */

resource "google_compute_instance_group_manager" "appserver" {
  name               = "gcigm"
  base_instance_name = "app"
  instance_template  = "${google_compute_instance_template.appserver.self_link}"
  update_strategy    = "NONE"
  zone               = "${var.zone}"

  target_pools = ["${google_compute_target_pool.appserver_p.self_link}"]
  target_size  = 2

  named_port {
    name = "customhttp"
    port = 7235
  }

#  auto_healing_policies {
#    health_check      = "${google_compute_health_check.autohealing.self_link}"
#    initial_delay_sec = 300
#  }
}

resource "google_compute_target_pool" "appserver_p" {
  name = "prjtpool"
  
#  instances = [
#    "${google_compute_instance_group_manager.appserver.self_link}"
#  ]
}

#resource "google_compute_health_check" "autohealing" {
#  name                = "autohealing-health-check"
#  check_interval_sec  = 5
#  timeout_sec         = 5
#  healthy_threshold   = 2
#  unhealthy_threshold = 10
#}


/**
 * A teamplate for instances within the group including its their formative image
 */

resource "google_compute_instance_template" "appserver" {
  description = "This template is used to create app server instances."
  project     = "${var.project_id}"
  region      = "${var.region}"

  instance_description = "This instance is part of a group that acts as an appserver"
  machine_type         = "f1-micro"
  can_ip_forward       = false

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  disk {
    source_image = "debian-cloud/debian-9"
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network = "${google_compute_network.network.self_link}"
  }
}

resource "google_compute_disk" "appserver-disk" {
  name  = "gcp-disk"
  image = "${data.google_compute_image.debian.self_link}"
  type  = "pd-ssd"
  zone  = "${var.zone}"
}


data "google_compute_image" "debian" {
  family  = "debian-9"
  project = "debian-cloud"
}

