resource "google_compute_instance" "app" {
  name         = "my-tofu-machine"
  machine_type = "n1-standard-1"

  boot_disk {
    initialize_params {
      image = "ubuntu-minimal-2410-oracular-amd64-v20250312"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }
}

resource "google_compute_instance_group" "buzz" {
  name      = "buzz"
  instances = [google_compute_instance.app.self_link]
}
