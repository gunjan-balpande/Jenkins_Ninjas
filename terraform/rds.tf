resource "aws_db_instance" "my_rds" {
  allocated_storage    = 20
  engine             = "mysql"
  engine_version     = "8.0.35"  # Specify the desired MySQL version
  instance_class     = "db.t3.micro"
  db_name            = "jenkins_ninjas_mysdl_rds"  # Initial database name
  username           = "admin"
  password           = "Jenkins_Ninjas"  # Use a secure method to manage passwords
  #db_subnet_group_name = aws_db_subnet_group.public.name
  db_subnet_group_name = aws_db_subnet_group.private.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]  # Ensure you have a security group allowing access

  skip_final_snapshot = true
  publicly_accessible  = false  # Set to true to allow public access

  tags = {
    Name = "Jenkins_Ninjas_MySQL_RDS"
  }
}

#output "rds_endpoint" {
 # value = aws_db_instance.my_rds.endpoint
#}