resource "aws_instance" "web" {
  ami           = "ami-0731b5a29c85c1f0c" 
  instance_type = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
  subnet_id     = aws_subnet.public.id
  key_name      = "Jenkins_Ninjas_US-WEST-1"  # Replace with your actual key pair name
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "Jenkins_Ninja_EC2_Web"
  }
}


resource "aws_instance" "rds" {
  ami           = "ami-0731b5a29c85c1f0c" 
  instance_type = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
  subnet_id     = aws_subnet.private.id
  key_name      = "Jenkins_Ninjas_US-WEST-1"  # Replace with your actual key pair name
  associate_public_ip_address = false
  vpc_security_group_ids = [aws_security_group.ec2_sg2.id, aws_security_group.rds_sg.id]

  tags = {
    Name = "Jenkins_Ninja_EC2_RDS"
  }
}