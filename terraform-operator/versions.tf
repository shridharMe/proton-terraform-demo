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
   backend "s3" {
    bucket         = "proton-terraform-states"
    key            = "terraform-operator/terraform.tfstate"
    region         = "us-east-2"
    encrypt        = true
  }
}