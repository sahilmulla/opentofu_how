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
