module "site" {
  source = "../3-compute_engine"

  zone        = "asia-south1-c"
  name_prefix = "prod"
}
