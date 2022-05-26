/*
This file is no longer managed by AWS Proton. The associated resource has been deleted in Proton.
*/

module "vpc" {
  source          = "terraform-aws-modules/vpc/aws"
  version         = "3.13.0"
  name            = var.environment.inputs.vpc_name
  cidr            = var.environment.inputs.vpc_cidr
  azs             = data.aws_availability_zones.available.names
  private_subnets = [var.environment.inputs.private_subnet_one_cidr,var.environment.inputs.private_subnet_two_cidr,var.environment.inputs.private_subnet_three_cidr ]
  public_subnets  = [var.environment.inputs.public_subnet_one_cidr,var.environment.inputs.public_subnet_two_cidr,var.environment.inputs.public_subnet_three_cidr ]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  enable_dns_hostnames = true
  enable_dns_support   = true
  
  tags = {
    Terraform   = "true"
    Environment = var.environment.inputs.project_environment
    Project     = var.environment.inputs.project_name
  }
}


data "aws_availability_zones" "available" {
  state = "available"
  filter {
    name   = "region-name"
    values = [var.environment.inputs.aws_region]
  }
}


