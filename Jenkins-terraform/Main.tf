resource "google_compute_firewall" "jenkins-firewall" {
  name    = "jenkins-firewall"
  network = "default" # Replace with your desired network

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443", "8080", "9000", "3000"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["jenkins-tag"]
}

resource "google_compute_instance" "web" {
  name         = "jenkins-instance"
  machine_type = "e2-standard-2"
  zone         = "us-west4-b" # Replace with your desired zone
  boot_disk {
    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20231101" 
      size = "10" # Size in GB
    }
  }

  network_interface {
    network = "default" # Replace with your desired network

    access_config {
      // Assigning an external IP to the instance
  }
  }

  tags = ["jenkins-tag"]

  metadata_startup_script = file("./jenkins_install.sh") # Replace with your startup script
}