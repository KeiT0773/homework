# RDS securiry_group 
resource "aws_security_group" "rds" {
  name        = "rds_sg"
  description = "Allow MySQL access"
  vpc_id      = aws_vpc.main_vpc.id
  ingress {
    description     = "MySQLL"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "securiry_group_rds_id" {
  value = aws_security_group.rds.id
}