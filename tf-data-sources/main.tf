terraform {
  required_providers {
    aws = { // can use any name here instead of aws, for readability using aws
      source = "hashicorp/aws"
      version = "6.6.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

# Search AMI ID using below filters
# data "aws_ami" "name" {
#   most_recent = true
#   owners = [ "amazon" ]
# }

# output "aws_ami" {
#   #value = data.aws_ami.name # Getting all details for AMI
#   value = data.aws_ami.name.id # Getting just the ID for AMI
# }

#Security group
data "aws_security_group" "name" {
  tags = {
    Tag = "Load Balancer"
  }
}

output "aws_security_group" {
  value = data.aws_security_group.name
}

#Availability Zone
data "aws_availability_zones" "names" {
  state = "available"
}

output "aws_zones" {
  value = data.aws_availability_zones.names
}

# Get the user info
data "aws_caller_identity" "name" {
}

output "caller_identity" {
  value = data.aws_caller_identity.name
}

# Get aws region
data "aws_region" "name" {
}

output "region-name" {
  value = data.aws_region.name
}

######## Comment this entire thing to run since we dont have vpc in AWS ##########

# VPC Id
data "aws_vpc" "name" {
  tags = {
    ENV  = "PROD"
    Name = "my-vpc"
  }
}

output "vpc_id" {
  value = data.aws_vpc.name.id
}

# Get subnet ID
data "aws_subnet" "name" {
  filter {
    name = "vpc-id"
    values = [ data.aws_vpc.name.id ]
  }
  # Now one VPC can have multiple subnets
  tags = {
    Name = "private-subnet" # Key=Name Value=private-subnet
  }
}

# Create an EC2 instance using existing VPC, private-subnet & security group
resource "aws_instance" "mywebserver" {
  ami = "ami-0d0ad8bb301edb745"
  instance_type = "t2.micro"
  subnet_id = data.aws_subnet.name.id
  security_groups = [ data.aws_security_group.name.id ] # already fetching sg using data source

  tags = {
          Name = "TerraformServer"
      }
}
######## Comment END ##########