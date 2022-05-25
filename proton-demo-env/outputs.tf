/*
This file is managed by AWS Proton. Any changes made directly to this file will be overwritten the next time AWS Proton performs an update.

To manage this resource, see AWS Proton Resource: arn:aws:proton:us-east-2:753690273280:environment/proton-demo-env

If the resource is no longer accessible within AWS Proton, it may have been deleted and may require manual cleanup.
*/

output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The VPC id"
}

output "private_subnets" {
  value       = module.vpc.private_subnets
  description = "The private subnets id"
}

output "public_subnets" {
  value       = module.vpc.public_subnets
  description = "The public subnets id"
}

output "vpc_cidr_block" {
  value       = var.environment.inputs.vpc_cidr
  description = "The VPC id"
}

