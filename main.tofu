# resource "google_compute_instance" "app" {
#   name         = "my-tofu-machine"
#   machine_type = "n1-standard-1"
#   zone         = var.zone

#   boot_disk {
#     initialize_params {
#       image = "ubuntu-minimal-2210-kinetic-amd64-v20230126"
#     }
#   }

#   network_interface {
#     network = "default"
#     access_config {}
#   }
# }

variable "greeting" {
  default = "Hello"
  type    = string
}

resource "local_file" "main-1" {
  content  = "${var.greeting}, tofu"
  filename = "${path.module}/out_1.txt"
}

data "http" "todo" {
  url = "https://jsonplaceholder.typicode.com/todos/1"
}

resource "local_file" "todo_headers" {
  content  = join("\n", [for key, value in data.http.todo.response_headers : "${key}=${value}"])
  filename = "${path.module}/todo_headers.txt"
}

resource "local_file" "todo_data" {
  content  = data.http.todo.response_body
  filename = "${path.module}/todo_data.json"
}

resource "local_file" "other" {
  content  = jsondecode(local_file.todo_data.content).title
  filename = "${path.module}/title.txt"
}
