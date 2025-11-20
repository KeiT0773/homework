#Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "aws-study-IGW-${var.my_env}"
  }
}

output "internet_gateway_id" {
  value = aws_internet_gateway.gw.id
}