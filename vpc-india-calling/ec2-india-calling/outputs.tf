/*
This file is no longer managed by AWS Proton. The associated resource has been deleted in Proton.
*/

output "subnet_cidr_blocks" {
  value = jsonencode([for s in data.aws_subnet.subnet : s.cidr_block])
}

output "ec2_ids" {
  description = "The ID of the instance"
  value       = jsonencode([for s in module.ec2_instance : s.id])
}