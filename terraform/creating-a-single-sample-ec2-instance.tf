resource "aws_instance" "single_sample_ec2_instance" {
  ami           = "ami-03265a0778a880afb"
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }
}