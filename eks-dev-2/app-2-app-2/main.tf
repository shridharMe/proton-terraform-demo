/*
This file is no longer managed by AWS Proton. The associated resource has been deleted in Proton.
*/

resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.service_instance.inputs.namespace_name
  }
}
