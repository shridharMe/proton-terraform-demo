/*
This file is managed by AWS Proton. Any changes made directly to this file will be overwritten the next time AWS Proton performs an update.

To manage this resource, see AWS Proton Resource: arn:aws:proton:us-east-2:753690273280:environment/dev-env

If the resource is no longer accessible within AWS Proton, it may have been deleted and may require manual cleanup.
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

output "aws_region" {
  description = "The VPC aws region"
  value       = local.local_data.environment.inputs.aws_region
}
