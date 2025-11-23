# variables
variable "my_ami" {}
variable "key_name" {}

# EC2
resource "aws_instance" "ec2_1" {
  ami                    = var.my_ami
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.PublicAZ1a.id
  vpc_security_group_ids = [aws_security_group.ec2.id]
  key_name               = var.key_name

  tags = {
    Name = "aws-study-ec2_1-${var.my_env}"
  }
}

output "ec2_1_id" {
  value = aws_instance.ec2_1.id
}

output "ec2_1_public_ip" {
  value = aws_instance.ec2_1.public_ip
}

resource "aws_instance" "ec2_2" {
  ami                    = var.my_ami
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.PublicAZ1c.id
  vpc_security_group_ids = [aws_security_group.ec2.id]
  key_name               = var.key_name

  tags = {
    Name = "aws-study-ec2_2-${var.my_env}"
  }
}

output "ec2_2_id" {
  value = aws_instance.ec2_2.id
}

output "ec2_2_public_ip" {
  value = aws_instance.ec2_2.public_ip
}