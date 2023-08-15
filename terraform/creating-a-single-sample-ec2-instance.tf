data "aws_ami" "centos" {
  owners           = ["973714476881"]
  most_recent      = true
  name_regex       = "Centos-8-DevOps-Practice"
}

output "ami_id" {
  value = data.aws_ami.centos.image_id
}

resource "aws_instance" "single_sample_ec2_instance" {
  ami           = "ami-03265a0778a880afb"
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }
}

output "single_sample_ec2_instance" {
  value = aws_instance.single_sample_ec2_instance.public_ip
}