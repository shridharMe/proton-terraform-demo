/*
This file is managed by AWS Proton. Any changes made directly to this file will be overwritten the next time AWS Proton performs an update.

To manage this resource, see AWS Proton Resource: arn:aws:proton:us-west-2:753690273280:environment/eks-dev

If the resource is no longer accessible within AWS Proton, it may have been deleted and may require manual cleanup.
*/

output "cluster_name" {
  value = data.aws_eks_cluster.cluster.name
}

 output "cluster_region" {
  value = var.environment.inputs.aws_region
}

   