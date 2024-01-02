terraform {
  required_version = ">= 0.13.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0, < 6.0.0"
    }

    http = {
      source  = "hashicorp/http"
      version = ">= 3.4.1"
    }
  }
}
