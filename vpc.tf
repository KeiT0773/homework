# variables
variable "my_env" {}

# VPC
resource "aws_vpc" "main_vpc" {
  cidr_block           = "10.2.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "aws-study-${var.my_env}"
  }
}

output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

#Publeic Subnet
resource "aws_subnet" "PublicAZ1a" {
  vpc_id                  = aws_vpc.main_vpc.id
  availability_zone       = "ap-northeast-1a"
  cidr_block              = "10.2.0.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "aws-study-publicaz1a-${var.my_env}"
  }

}

resource "aws_subnet" "PublicAZ1c" {
  vpc_id                  = aws_vpc.main_vpc.id
  availability_zone       = "ap-northeast-1c"
  cidr_block              = "10.2.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "aws-study-publicaz1c-${var.my_env}"
  }

}

output "public_subnet_AZ1a_id" {
  value = aws_subnet.PublicAZ1a.id
}

output "public_subnet_AZ1c_id" {
  value = aws_subnet.PublicAZ1c.id
}

#Private Subnet
resource "aws_subnet" "PrivateAZ1a" {
  vpc_id                  = aws_vpc.main_vpc.id
  availability_zone       = "ap-northeast-1a"
  cidr_block              = "10.2.2.0/24"
  map_public_ip_on_launch = false

  tags = {
    Name = "aws-study-Privateaz1a-${var.my_env}"
  }

}

resource "aws_subnet" "PrivateAZ1c" {
  vpc_id                  = aws_vpc.main_vpc.id
  availability_zone       = "ap-northeast-1c"
  cidr_block              = "10.2.3.0/24"
  map_public_ip_on_launch = false

  tags = {
    Name = "aws-study-Privateaz1c-${var.my_env}"
  }

}

output "private_subnet_AZ1a_id" {
  value = aws_subnet.PrivateAZ1a.id
}

output "private_subnet_AZ1c_id" {
  value = aws_subnet.PrivateAZ1c.id
}