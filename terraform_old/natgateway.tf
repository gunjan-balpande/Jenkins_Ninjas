resource "aws_eip" "nat_eip" {
  domain = "vpc"  # Allocate the Elastic IP for use in a VPC
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id  # Reference the Elastic IP
  subnet_id    = aws_subnet.public.id  # Reference the new public subnet

  tags = {
    Name = "Jenkins_Ninjas_NATGateway"
  }
}