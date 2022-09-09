/*
This file is managed by AWS Proton. Any changes made directly to this file will be overwritten the next time AWS Proton performs an update.

To manage this resource, see AWS Proton Resource: arn:aws:proton:us-east-2:753690273280:service/ec2-super-service/service-instance/ec2-super-instance

If the resource is no longer accessible within AWS Proton, it may have been deleted and may require manual cleanup.
*/

output "subnet_cidr_blocks" {
  value = jsonencode([for s in data.aws_subnet.subnet : s.cidr_block])
}

output "ec2_ids" {
  description = "The ID of the instance"
  value       = jsonencode([for s in module.ec2_instance : s.id])
}