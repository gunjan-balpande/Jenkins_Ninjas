resource "aws_db_subnet_group" "public" {
  name       = "jenkins_ninjas_public_subnet_group"
  subnet_ids = [aws_subnet.public.id, aws_subnet.public_b.id]  # Include both subnets

  tags = {
    Name = "Jenkins_Ninjas_Public_Subnet_Group"
  }
}

resource "aws_db_subnet_group" "private" {
  name       = "jenkins_ninjas_private_subnet_group"
  subnet_ids = [aws_subnet.private.id, aws_subnet.private_b.id]  # Include both subnets

  tags = {
    Name = "Jenkins_Ninjas_Private_Subnet_Group"
  }
}