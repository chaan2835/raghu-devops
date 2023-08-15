data "aws_ami" "centos" {
  owners           = ["973714476881"]
  most_recent      = true
  name_regex       = "Centos-8-DevOps-Practice"
}

output "ami_id" {
  value = data.aws_ami.centos.image_id
}

resource "aws_instance" "single_sample_ec2_instance" {
  ami           = "data.aws_ami.centos.image_id"
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }
}

output "single_sample_ec2_instance" {
  value = aws_instance.single_sample_ec2_instance.public_ip
}

resource "aws_route53_record" "single_sample_ec2_instance" {
  zone_id = "Z06316191H5E0T109U87A"
  name    = "simple.roboshopk8.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.single_sample_ec2_instance.private_ip]
}