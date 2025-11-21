# variables
variable "my_ami" {}

# EC2
resource "aws_instance" "ec2_1" {
  ami                    = var.my_ami
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.PublicAZ1a.id
  vpc_security_group_ids = [aws_security_group.ec2.id]

  tags = {
    Name = "aws-study-ec2_1-${var.my_env}"
  }
}

output "ec2_1_id" {
  value = aws_instance.ec2_1.id
}

resource "aws_instance" "ec2_2" {
  ami                    = var.my_ami
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.PublicAZ1c.id
  vpc_security_group_ids = [aws_security_group.ec2.id]

  tags = {
    Name = "aws-study-ec2_2-${var.my_env}"
  }
}

output "ec2_2_id" {
  value = aws_instance.ec2_2.id
}