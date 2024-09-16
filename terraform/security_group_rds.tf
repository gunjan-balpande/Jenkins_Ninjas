resource "aws_security_group" "rds_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 3306  # MySQL default port
    to_port     = 3306
    protocol    = "tcp"
    #cidr_blocks = [aws_subnet.public.cidr_block]  # Allow access from the public subnet
    security_groups = [aws_security_group.ec2_sg.id]  # Allow access from the EC2 security group
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Jenkins_Ninjas_RDS_Security_Group"
  }
}