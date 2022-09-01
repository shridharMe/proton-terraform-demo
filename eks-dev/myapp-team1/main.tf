/*
This file is no longer managed by AWS Proton. The associated resource has been deleted in Proton.
*/

locals {
  local_data = jsondecode(file("${path.module}/proton.auto.tfvars.json"))
}

resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.service_instance.inputs.namespace_name
  }
}
