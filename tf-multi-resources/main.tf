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
  region = "ap-south-1"
}

locals {
  project = "project-01"
  
}

resource "aws_vpc" "my-aws_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${local.project}-vpc"
  }
}

# earlier without count we had to manually add two subnets
# resource "aws_subnet" "my-subnet" {
#   vpc_id = aws_vpc.my-aws_vpc.id
#   cidr_block = "10.0.0.0/24"
# }

# resource "aws_subnet" "my-subnet" {
#   vpc_id = aws_vpc.my-aws_vpc.id
#   cidr_block = "10.0.1.0/24"
# }

resource "aws_subnet" "my-subnet" {
  vpc_id = aws_vpc.my-aws_vpc.id
  cidr_block = "10.0.${count.index}.0/24"
  count = 2
  tags = {
    Name = "${local.project}-subnet-${count.index}"
  }
}

# Create 2 instances each in 2 subnets
# resource "aws_instance" "main" {
#   ami = "ami-0d0ad8bb301edb745"
#   instance_type = "t2.micro"
#   count = 4
#   subnet_id = element(aws_subnet.my-subnet[*].id, count.index % length(aws_subnet.my-subnet)) # 0%2=0 1%2=1 2%2=0 3%2=1
  
#   tags = {
#     Name = "${local.project}-instance-${count.index}"
#   }
# }

# Create one instances with different ami in 2 subnets
# resource "aws_instance" "main" {
#   count = length(var.ec2_config)
  
#   ami = var.ec2_config[count.index].ami
#   instance_type = var.ec2_config[count.index].instance_type
  
#   subnet_id = element(aws_subnet.my-subnet[*].id, count.index % length(aws_subnet.my-subnet)) # 0%2=0 1%2=1 2%2=0 3%2=1
  
#   tags = {
#     Name = "${local.project}-instance-${count.index}"
#   }
# }

#For each we use if with map or set
resource "aws_instance" "main" {
  for_each = var.ec2_map
  # we will get each.key and each.value
  # each.key=ubuntu each.value={ami=,instance_type=}
  
  ami = each.value.ami
  instance_type = each.value.instance_type
  
  subnet_id = element(aws_subnet.my-subnet[*].id, index(keys(var.ec2_map), each.key) % length(aws_subnet.my-subnet))
  
  tags = {
    Name = "${local.project}-instance-${each.key}" #each.key = ubuntu, amazon-linux
  }
}

output "aws_subnet_id" {
  value = aws_subnet.my-subnet[0].id
}