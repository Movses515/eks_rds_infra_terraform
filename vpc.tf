module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "demo"
  cidr = "10.0.0.0/16"

  azs             = slice(data.aws_availability_zones.available.names, 0, 3)
  public_subnets  = ["10.0.0.0/20", "10.0.16.0/20"]
  private_subnets = ["10.0.32.0/19", "10.0.64.0/19"]

  enable_nat_gateway = true
  single_nat_gateway = true

  map_public_ip_on_launch = true
}

data "aws_availability_zones" "available" {}