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
  zone        = var.zone
  credentials = "../learn-tofu-f79ddb012979.json"
}
