terraform {
  backend "s3" {
    key    = "drone-ci-slackbot.json"
    region = "eu-west-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}

module "aws_tags" {
  source = "./modules/aws_tags"

  build       = var.build
  commit      = var.commit
  environment = terraform.workspace
  repository  = var.repository
  service     = var.service
}

module "slackbot_function" {
  source = "./modules/slackbot_function"

  function_key   = var.function_key
  layer_key      = var.layer_key
  package_bucket = var.package_bucket
  tags           = module.aws_tags.value
}
