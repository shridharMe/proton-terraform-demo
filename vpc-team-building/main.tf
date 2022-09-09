/*
This file is no longer managed by AWS Proton. The associated resource has been deleted in Proton.
*/

locals {
  local_data = jsondecode(file("${path.module}/proton.auto.tfvars.json"))
}
module "vpc" {
  source          = "terraform-aws-modules/vpc/aws"
  version         = "3.13.0"
  name            = local.local_data.environment.inputs.vpc_name
  cidr            = local.local_data.environment.inputs.vpc_cidr
  azs             = data.aws_availability_zones.available.names
  private_subnets = [local.local_data.environment.inputs.private_subnet_one_cidr,local.local_data.environment.inputs.private_subnet_two_cidr,local.local_data.environment.inputs.private_subnet_three_cidr ]
  public_subnets  = [local.local_data.environment.inputs.public_subnet_one_cidr,local.local_data.environment.inputs.public_subnet_two_cidr,local.local_data.environment.inputs.public_subnet_three_cidr ]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  enable_dns_hostnames = true
  enable_dns_support   = true
  
  tags = {
    Terraform   = "true"
    Environment = local.local_data.environment.inputs.project_environment
    Project     = local.local_data.environment.inputs.project_name
  }
}


data "aws_availability_zones" "available" {
  state = "available"
  filter {
    name   = "region-name"
    values = [local.local_data.environment.inputs.aws_region]
  }
}


