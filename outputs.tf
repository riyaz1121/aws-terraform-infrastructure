output "vpc_id" {
  description = "ID of the created VPC."
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets."
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of the private subnets."
  value       = module.vpc.private_subnet_ids
}

output "optional_ec2_public_ip" {
  description = "Public IP of the optional EC2 instance, if enabled."
  value       = var.enable_ec2 ? module.ec2[0].public_ip : null
}
