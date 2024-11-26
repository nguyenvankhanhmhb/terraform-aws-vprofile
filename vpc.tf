module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name                 = var.VPC_NAME
  cidr                 = var.VpcCIDER
  azs                  = [var.ZONE1, var.ZONE2, var.ZONE3]
  public_subnets       = [var.PubSub1CIDER, var.PubSub2CIDER, var.PubSub3CIDER]
  private_subnets      = [var.PrivSub1CIDER, var.PrivSub2CIDER, var.PrivSub3CIDER]
  enable_nat_gateway   = true
  single_nat_gateway   = true # as we have multiple private subnet it will create multiple NAT gateway which will be expenssive so, we are adding this attribute.
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    terraform   = "True"
    Environment = "Prod"
  }

  vpc_tags = {
    Name = var.VPC_NAME
  }
}
