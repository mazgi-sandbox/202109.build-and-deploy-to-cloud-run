# --------------------------------
# Terraform configuration

terraform {
  # https://www.terraform.io/downloads.html
  required_version = "1.0.6"

  required_providers {
    # # https://registry.terraform.io/providers/hashicorp/aws/latest
    # aws         = "3.57.0"
    # https://registry.terraform.io/providers/hashicorp/google/latest
    google      = "3.82.0"
    google-beta = "3.82.0"
  }

  backend "gcs" {
    prefix = "default/terraform"
  }
}

# provider "aws" {
#   access_key = var.aws_access_key
#   secret_key = var.aws_secret_key
#   region     = var.aws_default_region
# }

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_default_region
  zone    = "${var.gcp_default_region}-a"
}

provider "google-beta" {
  project = var.gcp_project_id
  region  = var.gcp_default_region
  zone    = "${var.gcp_default_region}-a"
}
