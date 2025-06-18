module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.37"

  cluster_name                   = "my-eks-cluster"
  cluster_version                = "1.33"
  cluster_endpoint_public_access = true

  enable_cluster_creator_admin_permissions = true

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.public_subnets
  control_plane_subnet_ids = module.vpc.public_subnets

  eks_managed_node_groups = {
    webservice = {
      instance_types = ["t3.medium"]
      capacity_type  = "SPOT"
      min_size       = 1
      desired_size   = 1
      max_size       = 2
      subnet_ids     = module.vpc.private_subnets
    }
  }

  tags = {
    Environment = "Test"
    Terraform   = "True"
  }
}