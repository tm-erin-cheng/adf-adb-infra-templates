locals {
  tags = {
    Project     = var.project_name
    Environment = var.env
    Terraformed = "true"
  }
}