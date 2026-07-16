terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region                      = "us-east-1"
  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  # Redirect all API requests to the MiniStack container on port 4566
  endpoints {
    s3       = "http://localhost:4566"
    ecs      = "http://localhost:4566"
    rds      = "http://localhost:4566"
    iam      = "http://localhost:4566"
    ecr      = "http://localhost:4566"
    eks      = "http://localhost:4566"
  }
}
