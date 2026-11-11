# AWS Infrastructure Automation with Terraform

A modular Terraform project that provisions a foundational AWS network:
- Custom VPC
- Two public and two private subnets across availability zones
- Internet Gateway and public routing
- Optional NAT Gateway for private-subnet internet access (disabled by default)
- Security group for an optional EC2 web instance
- Optional EC2 instance (disabled by default)

> **Cost warning:** AWS resources can incur charges. NAT Gateways, EC2 instances, Elastic IPs, and data transfer are chargeable. Defaults avoid creating NAT Gateways and EC2 instances. Review your AWS pricing and account limits before applying.

## Architecture

```text
                         Internet
                            |
                     Internet Gateway
                            |
                    Public Route Table
                       /          \
                Public Subnet A  Public Subnet B
                       \          /
                         VPC
                       /          \
               Private Subnet A  Private Subnet B
                    (no NAT by default)
```

## Prerequisites
- Terraform >= 1.5
- AWS CLI configured with credentials
- An AWS account and permission to create VPC/network resources

Never commit AWS access keys, secret keys, `.tfstate` files, or `.terraform/` directories.

## Quick start

```bash
terraform init
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
```

To remove resources created by this project:

```bash
terraform destroy
```

## Configuration

Copy `terraform.tfvars.example` to `terraform.tfvars` and adjust values.

```hcl
project_name       = "riyaz-devops"
aws_region         = "ap-south-1"
vpc_cidr           = "10.0.0.0/16"
public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24"]
enable_nat_gateway = false
enable_ec2         = false
```

For private-subnet outbound internet access, set `enable_nat_gateway = true`. A NAT Gateway has ongoing hourly and data-processing charges.

To launch the optional demo EC2 instance, set `enable_ec2 = true`. It is placed in a public subnet and accepts HTTP from the internet. SSH is not opened. The instance uses an Amazon Linux 2023 AMI selected through AWS Systems Manager public parameters.

## Outputs
Terraform prints the VPC ID, subnet IDs, and optional EC2 public IP after apply.

## Suggested portfolio enhancements
1. Add remote state in a dedicated S3 bucket with versioning and encryption.
2. Add CI validation with GitHub Actions.
3. Add VPC Flow Logs and CloudWatch logging.
4. Add private EC2 access through Systems Manager Session Manager.
5. Add architecture screenshots after a successful deployment.

## Repository structure

```text
.
├── main.tf
├── variables.tf
├── outputs.tf
├── versions.tf
├── provider.tf
├── terraform.tfvars.example
├── .gitignore
└── modules/
    ├── vpc/
    ├── security/
    └── ec2/
```
