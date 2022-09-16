/*
This file is no longer managed by AWS Proton. The associated resource has been deleted in Proton.
*/

data "template_file" "credentials" {
  template = "${file("${path.module}/credentials.example")}"
  vars = {
    TERRAFORM_CLOUD_API_TOKEN = var.environment.inputs.terraform_cloud_api_token
  }
}

provider "kubernetes" {
    config_path = "~/.kube/config"
}


// Create terraformrc secret for Operator
resource "kubernetes_secret" "terraformrc" {
  metadata {
    name      = "terraformrc"
    namespace = "edu"
  }

  data = {
    "credentials" = data.template_file.credentials.rendered
  }
}

// Create workspace secret for Operator
resource "kubernetes_secret" "workspacesecrets" {
  metadata {
    name      = "workspacesecrets"
    namespace = "edu"
  }

data = {
    "AWS_ACCESS_KEY_ID"     = var.environment.inputs.aws_access_key_id
    "AWS_SECRET_ACCESS_KEY" = var.environment.inputs.aws_secret_access_key
    "AWS_SESSION_TOKEN"     = var.environment.inputs.aws_session_token
  }
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

// Terraform Cloud Operator for Kubernetes helm chart
resource "helm_release" "operator" {
  name       = "terraform-operator"
  repository = "https://helm.releases.hashicorp.com"
  chart      = "terraform"

  namespace = "edu"

  depends_on = [
    kubernetes_secret.terraformrc,
    kubernetes_secret.workspacesecrets
  ]
}

resource "kubernetes_namespace" "edu" {
  metadata {
    name = "edu"
  }
}