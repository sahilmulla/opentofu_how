resource "google_storage_bucket" "foo" {
  name                        = "open_tofu_foo"
  location                    = "ASIA"
  force_destroy               = true
  uniform_bucket_level_access = true
  hierarchical_namespace {
    enabled = true
  }
}

resource "google_storage_folder" "test" {
  for_each = toset(["f_1", "f_2"])

  bucket = google_storage_bucket.foo.name
  name   = "${each.key}/"
}

variable "todo_id" {
  type        = set(string)
  description = "id of todo"
}

data "http" "todo" {
  for_each = var.todo_id
  url      = "https://jsonplaceholder.typicode.com/todos/${each.value}"
}

resource "google_storage_bucket_object" "todo_data" {
  for_each = var.todo_id

  bucket = google_storage_bucket.foo.name

  name    = "f_1/todo:${each.value}"
  content = data.http.todo[each.key].response_body
}
