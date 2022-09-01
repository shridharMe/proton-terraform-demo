/*
This file is no longer managed by AWS Proton. The associated resource has been deleted in Proton.
*/

output "endpoint" {
  value = data.aws_eks_cluster.cluster.endpoint
}

output "kubeconfig_certificate_authority_data" {
  value = data.aws_eks_cluster.cluster.certificate_authority[0].data
}

# Only available on Kubernetes version 1.13 and 1.14 clusters created or upgraded on or after September 3, 2019.
output "identity-oidc-issuer" {
  value = data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}

output "cluster_name" {
  value = data.aws_eks_cluster.cluster.name
}


 
 output "cluster_region" {
  value = var.environment.inputs.aws_region
}

   