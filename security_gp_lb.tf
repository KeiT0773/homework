# ELB securiry_group 
resource "aws_security_group" "elb" {
  name        = "elb_sg"
  description = "Allow SSH access"
  vpc_id      = aws_vpc.main_vpc.id
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "securiry_group_elb_id" {
  value = aws_security_group.elb.id
}