terraform {
  required_providers {
    aws = { // can use any name here instead of aws, for readability using aws
      source = "hashicorp/aws"
      version = "6.6.0"
    }
  }
  backend "s3" {
    bucket = "demo-bucket-bvn-eb95afa5ffc7bd17"
    key = "backend.tfstate"
    region = "ap-south-1"
    
  }
}

provider "aws" {
  # Configuration options
  region = "ap-south-1"
}

resource "aws_instance" "mywebserver" {
  ami = "ami-0d0ad8bb301edb745"
  instance_type = "t2.micro"

tags = {
        Name = "TerraformServer"
    }
}