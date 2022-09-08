/*
This file is managed by AWS Proton. Any changes made directly to this file will be overwritten the next time AWS Proton performs an update.

To manage this resource, see AWS Proton Resource: arn:aws:proton:us-east-2:753690273280:service/test-service/service-instance/tong-instance

If the resource is no longer accessible within AWS Proton, it may have been deleted and may require manual cleanup.
*/

resource "kubernetes_namespace" "namwspace" {
  metadata {
    name = var.service.inputs.namespace_name
  }
}