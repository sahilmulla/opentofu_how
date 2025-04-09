terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.28.0"
    }
  }
}

locals {
  zone = "asia-south-1c"
}


provider "google" {
  project     = "learn-tofu"
  zone        = local.zone
  credentials = "../learn-tofu-f79ddb012979.json"
}
