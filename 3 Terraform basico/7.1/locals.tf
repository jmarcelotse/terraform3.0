locals {
  ip_filepath = "ips.json"
  common_tags = {
    Service     = "Curso Terraform",
    ManagedBy   = "Noah Tse",
    Environment = var.environment,
    Owner       = "Jose Marcelo Tse"
  }
}
