terraform {
  required_providers {
    aws = { // can use any name here instead of aws, for readability using aws
      source = "hashicorp/aws"
      version = "6.6.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.7.2"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "ap-south-1"
}

resource "random_id" "rand_id" {
  byte_length = 8
}

resource "aws_s3_bucket" "demo-bucket" {
  bucket = "demo-bucket-${terraform.workspace}-${random_id.rand_id.hex}" 
}
