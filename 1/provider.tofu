provider "google" {
  project = "learn-tofu"
  region  = var.region
  zone    = var.zone

  credentials = "../learn-tofu-f79ddb012979.json"
}
