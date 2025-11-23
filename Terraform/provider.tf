terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>6.14.0"
    }
  }

  backend "s3" {
    bucket       = "ecs-project-s3"
    key          = "terraform.tfstate"
    region       = "eu-north-1"
    use_lockfile = true #s3 native locking 
  }
}

provider "aws" {
  region = "eu-north-1"
}
