ec2_config = [ {
  ami = "ami-0f918f7e67a3323f0" #ubuntu
  instance_type = "t2.micro" 
}, {
    ami = "ami-0d0ad8bb301edb745" #amazon linux
    instance_type = "t3.micro"
} ]

ec2_map = {
  "ubuntu" = {
    ami = "ami-0f918f7e67a3323f0" #ubuntu
    instance_type = "t2.micro" 
  },
  "amazon-linux" = {
    ami = "ami-0d0ad8bb301edb745" #amazon linux
    instance_type = "t3.micro"
  }
}