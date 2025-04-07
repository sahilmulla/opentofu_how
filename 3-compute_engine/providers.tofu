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
