region = "us-east-1"

vpc_cidr = "10.0.0.0/16"

enable_dns_support = "true"

enable_dns_hostnames = "true"

enable_classiclink = "false"

enable_classiclink_dns_support = "false"

preferred_number_of_public_subnets = 2

preferred_number_of_private_subnets = 4

environment = "dev"

ami-web = "ami-0b8e0ccfe97830aa4"

ami-bastion = "ami-06e2324f0c9fc0b66"

ami-nginx = "ami-06b8c992c240700f8"

ami-sonar = "ami-02042e7a8feb9d14f"

keypair = "devops1"

master-password = "admin12345"

master-username = "admin"

account_no = 144145541408

tags = {
  Owner-Email     = "tonysonokojie+dev@gmail.com"
  Managed-By      = "Terraform"
  Billing-Account = "1234567890"
}