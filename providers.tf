terraform {
  required_version = ">= 1.4.6"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.62.0"
    }
    ec = {
      source  = "elastic/ec"
      version = "0.5.0"
    }
  }
}
