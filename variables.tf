variable "project_name" {
  description = "Prefix used to name project resources."
  type        = string
  default     = "riyaz-devops"
}

variable "environment" {
  description = "Deployment environment."
  type        = string
  default     = "dev"
}

variable "aws_region" {
  description = "AWS region for deployment."
  type        = string
  default     = "ap-south-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets (two AZs recommended)."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets (two AZs recommended)."
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "enable_nat_gateway" {
  description = "Whether to create one NAT Gateway for private subnet egress. This incurs charges."
  type        = bool
  default     = false
}

variable "enable_ec2" {
  description = "Whether to create a small demo web server in a public subnet. This incurs charges."
  type        = bool
  default     = false
}

variable "ec2_instance_type" {
  description = "EC2 instance type for the optional demo web server."
  type        = string
  default     = "t3.micro"
}
