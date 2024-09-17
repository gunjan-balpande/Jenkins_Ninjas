# EC2

variable "ec2_instance_type" {
  description = "AWS EC2 instance type."
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0731b5a29c85c1f0c" 
}

variable "ec2_web" {
  type = string
  default = "Jenkins_Ninja_EC2_Web"
}

variable "ec2_rds" {
  type = string
  default = "Jenkins_Ninja_EC2_RDS"
}


# VPC

variable "vpc_cidr" {
  description = "Value of cidr of VPC" 
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  type = string
  default = "Jenkins_Ninja_VPC"
}


# Subnet, Subnet_Group 

variable "subnet_public" {
  type = string
  default = "Jenkins_Ninjas_Public_Subnet"
}

variable "subnet_public_b" {
  type = string
  default = "Jenkins_Ninjas_Public_Subnet_B"
}

variable "subnet_private" {
  type = string
  default = "Jenkins_Ninjas_Private_Subnet"
}

variable "subnet_private_b" {
  type = string
  default = "Jenkins_Ninjas_Private_Subnet_B"
}


# Subnet_Group

variable "subnet_private_group" {
  type = string
  default = "jenkins_ninjas_private_subnet_group"
}

variable "subnet_public_group" {
  type = string
  default = "jenkins_ninjas_public_subnet_group"
}


# Security_Groups

variable "security_groups_rds" {
  type = string
  default = "Jenkins_Ninjas_RDS_Security_Group"
}

variable "security_groups_ec2" {
  type = string
  default = "Jenkins_Ninjas_ec2-security-group"
}

variable "security_groups_ec2_b" {
  type = string
  default = "Jenkins_Ninjas_ec2-security-group2"
}


# S3_Bucket

variable "s3_static" {
  type = string
  default = "jenkins-ninjas-static-website-bucket"
}

variable "s3_backup" {
  type = string
  default = "jenkins-ninjas-backup-bucket"
}


# Route_table

variable "route_table_public" {
  type = string
  default = "Jenkins_Ninja_Public_Route_Table"
}

variable "route_table_private" {
  type = string
  default = "Jenkins_Ninjas_PrivateRouteTable"
}


# RDS

variable "rds" {
  type = string
  default = "Jenkins_Ninjas_MySQL_RDS"
}


# NAT_Gateway

variable "nat_gateway" {
  type = string
  default = "Jenkins_Ninjas_NATGateway"
}


# Internet_Gateway

variable "internet_gateway" {
  type = string
  default = "Jenkins_Ninja_Internet_Gateway"
}


# IAM

variable "iam_rds_policy" {
  type = string
  default = "RDSFullAccess"
}

variable "iam_s3_policy" {
  type = string
  default = "S3FullAccess"
}

variable "iam_ec2_policy" {
  type = string
  default = "EC2FullAccessRole"
}

variable "iam_ec2_profile" {
  type = string
  default = "EC2InstanceProfile"
}




