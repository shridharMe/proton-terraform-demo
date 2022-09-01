/*
This file is no longer managed by AWS Proton. The associated resource has been deleted in Proton.
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
  }
  required_version = "~>1.0"
}


provider "aws" {
  region  = var.environment.outputs.cluster_region
}


data "aws_eks_cluster" "cluster" {
  name =var.environment.outputs.cluster_name
}

provider "kubernetes" {
  host                   = var.environment.outputs.endpoint
  cluster_ca_certificate = base64decode(var.environment.outputs.kubeconfig_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    command     = "aws"
    args = [
      "eks",
      "get-token",
      "--cluster-name",
      var.environment.outputs.cluster_name
    ]
  }
}
