/*
This file is managed by AWS Proton. Any changes made directly to this file will be overwritten the next time AWS Proton performs an update.

To manage this resource, see AWS Proton Resource: arn:aws:proton:us-east-2:753690273280:service/service-citi/service-instance/service-dev

If the resource is no longer accessible within AWS Proton, it may have been deleted and may require manual cleanup.
*/

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.14.0"
    }
    template = {
      source  = "hashicorp/template"
      version = "~>2.2.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.10"
    }
  }
  required_version = "~>1.0"
}

provider "aws" {
  region = var.environment.outputs.cluster_region
}

data "aws_eks_cluster" "cluster" {
  name = var.environment.outputs.eks_cluster_id
  vpc_config {
    vpc_id=var.environment.outputs.vpc_id
  }
}

data "aws_eks_cluster_auth" "cluster" {
  name = var.environment.outputs.eks_cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}
