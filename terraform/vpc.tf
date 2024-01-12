module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.5"

  name = var.cluster_name
  cidr = "10.42.0.0/16"


  azs             = ["us-west-2a", "us-west-2b", "us-west-2c"]
  private_subnets = ["10.42.1.0/24", "10.42.2.0/24", "10.42.3.0/24"]
  public_subnets  = ["10.42.101.0/24", "10.42.102.0/24", "10.42.103.0/24"]

  enable_nat_gateway   = true
  create_igw           = true
  enable_vpn_gateway   = false
  enable_dns_hostnames = true
  single_nat_gateway   = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
  
}
