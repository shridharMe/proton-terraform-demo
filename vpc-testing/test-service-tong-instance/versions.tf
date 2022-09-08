/*
This file is managed by AWS Proton. Any changes made directly to this file will be overwritten the next time AWS Proton performs an update.

To manage this resource, see AWS Proton Resource: arn:aws:proton:us-east-2:753690273280:service/test-service/service-instance/tong-instance

If the resource is no longer accessible within AWS Proton, it may have been deleted and may require manual cleanup.
*/

/*
This file is managed by AWS Proton. Any changes made directly to this file will be overwritten the next time AWS Proton performs an update.

To manage this resource, see AWS Proton Resource: arn:aws:proton:us-east-2:753690273280:environment/vpc-dev

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
  }
  required_version = "~>1.0"
}

provider "aws" {
  region  = var.service.inputs.aws_region
}


provider "aws" {
  region =  var.service.inputs.aws_region
}

data "aws_eks_cluster" "cluster" {
  name =var.service.inputs.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    command     = "aws"
    args = [
      "eks",
      "get-token",
      "--cluster-name",
      data.aws_eks_cluster.cluster.name
    ]
  }
}
