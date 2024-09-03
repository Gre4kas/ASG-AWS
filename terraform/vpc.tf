module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.12.1"

  name = "my-vpc"
  cidr = var.vpc_cidr

  azs = var.azs
  # Public Subnets
  public_subnets = var.public_subnets

  # Private Subnets for App Servers, etc.
  private_subnets = var.private_subnets

  # Database Subnets for RDS
  database_subnets = var.database_subnets

  # Create Subnet Group and Route Table for RDS
  create_database_subnet_group       = true
  create_database_subnet_route_table = true

  # NOTE: Below line is commented to ensure DB is private.
  # Uncomment only if you want public access to RDS (not recommended in production)
  # create_database_internet_gateway_route = true

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}