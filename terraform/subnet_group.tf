resource "aws_db_subnet_group" "public" {
  name       = var.subnet_public_group
  subnet_ids = [aws_subnet.public.id, aws_subnet.public_b.id]  

  tags = {
    Name = var.subnet_public
  }
}

resource "aws_db_subnet_group" "private" {
  name       = var.subnet_private_group
  subnet_ids = [aws_subnet.private.id, aws_subnet.private_b.id]  

  tags = {
    Name = var.subnet_private
  }
}