# EC2 securiry_group 
resource "aws_security_group" "ec2" {
  name        = "ec2_sg"
  description = "Allow SSH and web traffic"
  vpc_id      = aws_vpc.main_vpc.id
  ingress {
    description = "SSH from own enviroment"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["207.65.168.137/32"]
  }

  ingress {
    description     = "HTTP"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.elb.id]
  }

  ingress {
    description     = "HTTP-alt"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.elb.id]
  }

  ingress {
    description     = "HTTPS"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.elb.id]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.elb.id]
  }
}

output "securiry_group_ec2_id" {
  value = aws_security_group.ec2.id
}