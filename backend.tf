# terraform {
#   backend "s3" {
#     bucket         = "pbl-terraform-prj-18"
#     key            = "global/s3/terraform.tfstate"
#     region         = "us-east-1"
#     dynamodb_table = "terraform-locks"
#     encrypt        = true
#   }
# }

terraform {
  backend "remote" {
    organization = "RayRoyal"

    workspaces {
      name = "terraform-aws-pbl-19"
    }
  }
}