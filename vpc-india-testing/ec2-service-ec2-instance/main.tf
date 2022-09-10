/*
This file is managed by AWS Proton. Any changes made directly to this file will be overwritten the next time AWS Proton performs an update.

To manage this resource, see AWS Proton Resource: arn:aws:proton:us-east-2:753690273280:service/ec2-service/service-instance/ec2-instance

If the resource is no longer accessible within AWS Proton, it may have been deleted and may require manual cleanup.
*/

 locals {
  local_data = jsondecode(file("${path.module}/proton.auto.tfvars.json"))
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"
  for_each = toset(data.aws_subnets.subnets.ids)
  name = "instance-${each.key}"
  ami                    = local.local_data.service_instance.inputs.ami
  instance_type          = local.local_data.service_instance.inputs.instance_type
  monitoring             = true
  vpc_security_group_ids = [local.local_data.environment.outputs.vpc_security_group_id]
  subnet_id              = each.value

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}


data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [local.local_data.environment.outputs.vpc_id]
  }
}

data "aws_subnet" "subnet" {
  for_each = toset(data.aws_subnets.subnets.ids)
  id       = each.value
}

