variable "name_prefix" {
  type = string
}

module "site" {
  source = "../3-compute_engine"

  name_prefix = var.name_prefix
}
