/*
This file is no longer managed by AWS Proton. The associated resource has been deleted in Proton.
*/

data "aws_eks_cluster" "cluster" {
  name = var.environment.inputs.cluster_name
}