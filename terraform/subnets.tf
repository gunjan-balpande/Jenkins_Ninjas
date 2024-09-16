# Public Subnet
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id  # Reference to the main VPC
  cidr_block        = "10.0.1.0/24"     # CIDR block for the public subnet
  availability_zone = "us-west-1b" # Specify the availability zone
  map_public_ip_on_launch = true
  tags = {
    Name = "Jenkins_Ninjas_Public_Subnet" # Tag for identification
  }
}

# Public Subnet in AZ us-west-1c
resource "aws_subnet" "public_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-west-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "Jenkins_Ninjas_Public_Subnet_B"
  }
}

# Private Subnet
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id  # Reference to the main VPC
  cidr_block        = "10.0.3.0/24"     # CIDR block for the private subnet
  availability_zone = "us-west-1b" # Specify the availability zone
  map_public_ip_on_launch = false

  tags = {
    Name = "Jenkins_Ninjas_Private_Subnet" # Tag for identification
  }
}

# Private Subnet in AZ us-west-1c
resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-west-1c"
  map_public_ip_on_launch = false

  tags = {
    Name = "Jenkins_Ninjas_Private_Subnet_B"
  }
}