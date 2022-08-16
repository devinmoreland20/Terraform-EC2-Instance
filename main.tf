terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  region = "us-west-2"
}

module "compute" {
  source               = "./module/compute"
  ami                  = "ami-0d70546e43a941d70"
  instance_type        = "t2.micro"
  tag_name             = "ExampleAppServerInstance"
  sg                   = module.security.webserver_sg
  user_data            = file("./userdata.tpl")
  iam_instance_profile = module.iam.s3_profile
}

module "security" {
  source = "./module/security"
}

module "iam" {
  source                 = "./module/iam"
  role_name              = "s3-list-bucket"
  policy_name            = "s3-list-bucket"
  instance_profile_name  = "s3-list-bucket"
  path                   = "/"
  iam_policy_description = "s3 policy for ec2 to list role"
  iam_policy             = file("./s3-list-bucket-policy.tpl")
  assume_role_policy     = file("./s3-list-bucket-trusted-identity.tpl")
}
module "s3" {
  source        = "./module/s3"
  bucket_name   = "devinslevelupintechbucket0223"
  acl           = "private"
  object_key    = "LUIT"
  object_source = "/dev/null"
}
