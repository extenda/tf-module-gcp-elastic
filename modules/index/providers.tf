terraform {
  required_version = ">= 1.0.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.62.0"
    }
    elasticstack = {
      source  = "elastic/elasticstack"
      version = "0.5.0"
    }
  }
}
