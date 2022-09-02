/*
This file is no longer managed by AWS Proton. The associated resource has been deleted in Proton.
*/

output "cluster_name" {
  value = data.aws_eks_cluster.cluster.name
}

 output "cluster_region" {
  value = var.environment.inputs.aws_region
}