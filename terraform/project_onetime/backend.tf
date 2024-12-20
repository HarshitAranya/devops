# to clreate local cli profile for aws, use the following command -
# aws configure --profile name-of-profile
# export AWS_PROFILE=name-of-profile

# store the terraform state file in aws s3 bucket
terraform {
  backend "s3" {
    bucket = "backend_name"
    key = "onetime.tfstate" #project_name.tfstate
    region = var.region
    profile = "name-of-profile"
  }
}