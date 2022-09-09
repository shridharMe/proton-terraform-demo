/*
This file is no longer managed by AWS Proton. The associated resource has been deleted in Proton.
*/

output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The VPC id"
}

output "vpc_cidr_block" {
  value       = local.local_data.environment.inputs.vpc_cidr
  description = "The VPC id"
}

output "vpc_security_group_id" {
  description = "The ID of the security group created by default on VPC creation"
  value       = module.vpc.default_security_group_id
}