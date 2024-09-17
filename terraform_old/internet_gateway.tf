resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Jenkins_Ninja_Internet_Gateway"
  }
}