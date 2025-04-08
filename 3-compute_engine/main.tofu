resource "google_compute_instance" "app" {
  name         = "my-tofu-machine"
  machine_type = "n1-standard-1"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "ubuntu-minimal-2410-oracular-amd64-v20250312"
    }
  }

  tags = ["http-server"]

  network_interface {
    network = "default"
    access_config {
      network_tier = "STANDARD"
    }
  }

  metadata_startup_script = <<-EOF
    sudo date > out.txt
    sudo apt-get update
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh ./get-docker.sh
    sudo service docker start
    sudo docker run -d -p 80:80 nginx:latest

    EOF
}

# resource "google_compute_instance_group" "buzz" {
#   name      = "buzz"
#   instances = ["${google_compute_instance.app.id}"]
# }

output "instance" {
  value = tomap({
    id        = google_compute_instance.app.id
    self_link = google_compute_instance.app.self_link
  })
}
