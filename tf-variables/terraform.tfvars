aws_instance_type = "t3.micro"
ec2_config = {
    v_size = 16
    v_type = "gp3"
}
additional_tag = {
    ENV = "QA"
    TEST = "Test"
}