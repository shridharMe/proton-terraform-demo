/*
This file is managed by AWS Proton. Any changes made directly to this file will be overwritten the next time AWS Proton performs an update.

To manage this resource, see AWS Proton Resource: arn:aws:proton:us-east-2:753690273280:environment/eks-dev-2

If the resource is no longer accessible within AWS Proton, it may have been deleted and may require manual cleanup.
*/

output "cluster_region" {
  value = var.environment.inputs.aws_region
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = jsonencode(join(",", module.vpc.public_subnets))
}

output "private_subnets" {
  value = jsonencode(join(",", module.vpc.private_subnets))
}

output "eks_cluster_id" {
  value = module.eks_blueprints.eks_cluster_id
}
