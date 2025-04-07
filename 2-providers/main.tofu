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

variable "todo_ids" {
  type        = set(string)
  description = "ids of todo"
}

data "http" "todo" {
  for_each = var.todo_ids
  url      = "https://jsonplaceholder.typicode.com/todos/${each.value}"
}

resource "google_storage_bucket_object" "todo_data" {
  for_each = var.todo_ids

  bucket = google_storage_bucket.foo.name

  name    = "f_1/todo:${each.value}"
  content = data.http.todo[each.key].response_body
}
