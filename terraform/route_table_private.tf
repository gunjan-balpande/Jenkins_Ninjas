resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  route = []  # No routes defined initially

  tags = {
    Name = "Jenkins_Ninjas_PrivateRouteTable"
  }
}

resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route" "private_nat_route" {
  route_table_id         = aws_route_table.private_rt.id  # Reference your existing private route table
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id  # Reference the NAT Gateway
}