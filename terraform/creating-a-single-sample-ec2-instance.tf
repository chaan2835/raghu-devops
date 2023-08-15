data "aws_ami" "aws_ami_id" {
  most_recent      = true
  owners           = ["817611672488"]
  name_regex = "Centos-8-Devops-Practice"
}

output "ami_id" {
  value = data.aws_ami.aws_ami_id.image_id
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