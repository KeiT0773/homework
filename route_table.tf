#Route table for Public
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"                # Apopt all external network
    gateway_id = aws_internet_gateway.gw.id # Use internet gateway
  }

  tags = {
    Name = "aws-study-public-route-${var.my_env}"
  }
}

output "public_route_table_id" {
  value = aws_route_table.public.id
}

#Route table for Private
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "aws-study-privete-route-${var.my_env}"
  }
}

output "private_route_table_id" {
  value = aws_route_table.private.id
}

# Associsation between Public-subnet and Public-routetable 
resource "aws_route_table_association" "publicAZ1a" {
  subnet_id      = aws_subnet.PublicAZ1a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "publicAZ1c" {
  subnet_id      = aws_subnet.PublicAZ1c.id
  route_table_id = aws_route_table.public.id
}

# Associsation between Private-subnet and Private-routetable 
resource "aws_route_table_association" "privateAZ1a" {
  subnet_id      = aws_subnet.PrivateAZ1a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "privateAZ1c" {
  subnet_id      = aws_subnet.PrivateAZ1c.id
  route_table_id = aws_route_table.private.id
}