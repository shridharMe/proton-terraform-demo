/*
This file is managed by AWS Proton. Any changes made directly to this file will be overwritten the next time AWS Proton performs an update.

To manage this resource, see AWS Proton Resource: arn:aws:proton:us-east-2:753690273280:service/service-tetsting/service-instance/test-service-testing

If the resource is no longer accessible within AWS Proton, it may have been deleted and may require manual cleanup.
*/

module "sg" {
  source             = "git::https://github.com/shridharMe/terraform-modules.git//modules/lambda_sg/?ref=master"
  vpc_id             = var.environment.outputs.vpc_id
  vpc_cidr_block     = var.environment.outputs..vpc_cidr
  sg_for_lambda_name = join("", ["allow_tls"])
}
module "lambda_role" {
  source = "git::https://github.com/shridharMe/terraform-modules.git//modules/lambda_iam/?ref=master"
}

data "archive_file" "lambda_bgd_code" {
  type        = "zip"
  output_path = "lambda_bgd.zip"
  source_dir  = pathexpand("${path.module}/files/lambda")
}

module "lambda" {
  source                  =  "git::https://github.com/shridharMe/terraform-modules.git//modules/lambda/?ref=master"
  lambda_function_name    = join("", ["lambda_bgd"])
  vpc_id                  = var.environment.outputs.vpc_id
  private_subnets_ids     = var.environment.outputs.private_subnets
  vpc_cidr_block          = var.environment.outputs.vpc_cidr
  lambda_filename         = data.archive_file.lambda_bgd_code.output_path
  lambda_source_code_hash = data.archive_file.lambda_bgd_code.output_base64sha256
  lambda_role_arn         = module.lambda_role.iam_role_arn
  security_group_ids      = [module.sg.ids]
  lambda_handler          = "index.handler"
  lambda_runtime          = "python3.7"
}


module "apigw" {
  source               = "git::https://github.com/shridharMe/terraform-modules.git//modules/apigw/?ref=master"
  lambda_function_name = module.lambda.function_name
  lambda_invoke_arn    = module.lambda.invoke_arn
  apigatewayv2_name    = var.service.inputs.apigatewayv2_name
  route_key            = "GET /hello"
}

data "archive_file" "healthcheck_lambda_bgd_code" {
  type        = "zip"
  output_path = "healthcheck_lambda_bgd.zip"
  source_dir  = pathexpand("${path.module}/files/lambda_healthcheck")
}

module "lambda_healthcheck" {
  source                  = "git::https://github.com/shridharMe/terraform-modules.git//modules/lambda/?ref=master"
  lambda_function_name    = join("", ["lambda_bgd_healthcheck"])
  vpc_id                  = var.environment.outputs.vpc_id
  private_subnets_ids     = var.environment.outputs.private_subnets
  vpc_cidr_block          = var.environment.outputs.vpc_cidr
  lambda_filename         = data.archive_file.healthcheck_lambda_bgd_code.output_path
  lambda_source_code_hash = data.archive_file.healthcheck_lambda_bgd_code.output_base64sha256
  lambda_role_arn         = module.lambda_role.iam_role_arn
  security_group_ids      = [module.sg.ids]
  lambda_handler          = "index.handler"
  lambda_runtime          = "python3.7"
}

module "healthcheck_apigw" {
  source               = "git::https://github.com/shridharMe/terraform-modules.git//modules/apigw/?ref=master"
  lambda_function_name = module.lambda_healthcheck.function_name
  lambda_invoke_arn    = module.lambda_healthcheck.invoke_arn
  apigatewayv2_name    = join("_",["healthcheck",var.service.inputs.apigatewayv2_name])
  route_key            = "GET /healthcheck"
}
