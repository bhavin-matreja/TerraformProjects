terraform {
  required_providers {
    aws = { // can use any name here instead of aws, for readability using aws
      source  = "hashicorp/aws"
      version = "6.6.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "ap-south-1"
}

resource "aws_security_group" "main" {
  name = "my-sg"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcpp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "mywebserver" {
  ami           = "ami-0d0ad8bb301edb745"
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.main.id] #implicit dependency -
  depends_on             = [aws_security_group.main]    #explicit dependency - you writing it

  lifecycle {
    # create new instance first, then destroy the old instance.
    #create_before_destroy = true

    # prevents the instance to be destroyed (by accident or otherwise) - instance TOO IMPORTANT
    #prevent_destroy = true

    # ignore state changes for proerty after initally created
    ignore_changes = [
      ami
    ]

    # if any of given condition change, recreate the instance
    # without this, if we change the port to 8080, it will update sg without affecting instance
    #replace_triggered_by = [ aws_security_group.main, aws_security_group.main.ingress ]

    #Allow you to define checks that must be true before resource is created (precondition) 
    #and after a resource is created (postcondition).
    precondition {
      condition = ""
      error_message = ""
    }

    postcondition {
      condition = ""
      error_message = ""
    }
  }

  tags = {
    Name = "TerraformServer"
  }
}