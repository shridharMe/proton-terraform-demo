/*
This file is no longer managed by AWS Proton. The associated resource has been deleted in Proton.
*/

resource "kubernetes_namespace" "namwspace" {
  metadata {
    name = var.service.inputs.namespace_name
  }
}