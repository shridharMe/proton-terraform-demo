/*
This file is managed by AWS Proton. Any changes made directly to this file will be overwritten the next time AWS Proton performs an update.

To manage this resource, see AWS Proton Resource: arn:aws:proton:us-east-2:753690273280:environment/vpc-demo-1

If the resource is no longer accessible within AWS Proton, it may have been deleted and may require manual cleanup.
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


