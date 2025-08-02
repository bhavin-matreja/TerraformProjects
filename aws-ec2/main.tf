terraform {
  required_providers {
    aws = { // can use any name here instead of aws, for readability using aws
      source = "hashicorp/aws"
      version = "6.6.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = var.region
}

resource "aws_instance" "mywebserver" {
  ami = "ami-0d0ad8bb301edb745"
  instance_type = "t2.micro"

tags = {
        Name = "TerraformServer"
    }
}