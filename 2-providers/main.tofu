terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.28.0"
    }
  }
}

provider "google" {
  project     = "learn-tofu"
  zone        = "asia-south1-c"
  credentials = "../learn-tofu-f79ddb012979.json"
}

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
