terraform {  
  required_providers {  
    aws = {  
      source  = "hashicorp/aws"  
      version = "~> 4.0"  
    }  
    kubernetes = {  
      source  = "hashicorp/kubernetes"  
      version = "~> 2.0"  
    }  
  }  
}  

provider "aws" {  
  region = "ap-northeast-1"
}  

# vpc module  
module "vpc" {  
  source = "modules/vpc"  

  name = "test-vpc"  
  cidr = "10.0.0.0/16"  
  azs  = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]  
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]  
  public_subnets = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]  

  enable_nat_gateway = true  
  enable_vpn_gateway = true  

  tags = {  
    Terraform   = "true"  
    Environment = "dev"  
  }  
}  

# eks module  
module "eks" {  
  source  = "modules/eks"
  version = "1.30.0"  

  cluster_name = "test-eks"  
  cluster_endpoint_public_access = true  
  vpc_id = module.vpc.vpc_id  
  subnet_ids = module.vpc.private_subnets  

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"
    instance_types = ["m5.large"]

    attach_cluster_primary_security_group = true
  }

  eks_managed_node_groups = {
    my-worker-group = {
      min_size = 3
      max_size = 5 
      desired_size = 3

      instance_types = ["t3.large"]
      capacity_type  = "SPOT"

      tags = {
        ExtraTag = "asiayo-test"
      }
    }
  }

  tags = {
    Example = "test-eks"
  }
}


## the config to auto deploy resource to your eks with main.tf, but not finished
##
##
# configure k8s provider for eks  
# provider "kubernetes" {  
#   host                   = module.eks.cluster_endpoint  
#   token                  = data.aws_eks_cluster_auth.cluster_auth.token  
#   cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)  
# }  

# data "aws_eks_cluster_auth" "cluster_auth" {  
#   name = module.eks.cluster_id  
# }  

# add deploying some kubernetes mainfests here ...
