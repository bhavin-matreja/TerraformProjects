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

locals { # key/value pair
  owner = "XYZ Ltd"
  name = "TerraformServer"
}

resource "aws_instance" "mywebserver" {
  ami = "ami-0d0ad8bb301edb745"
  instance_type = var.aws_instance_type

  root_block_device {
    delete_on_termination = true
    volume_size = var.ec2_config.v_size
    volume_type = var.ec2_config.v_type
  }

  tags = merge(var.additional_tag, {
          Name = local.name
  })
}