resource "aws_eks_cluster" "this" {  
  name     = var.cluster_name  
  role_arn = aws_iam_role.eks_role.arn  

  vpc_config {  
    subnet_ids = var.subnet_ids  
  }  

  depends_on = [aws_iam_role_policy_attachment.eks_cluster_role]  
}  

resource "aws_iam_role" "eks_role" {  
  name = "${var.cluster_name}-role"  

  assume_role_policy = jsonencode({  
    Version = "2012-10-17",  
    Statement = [  
      {  
        Action    = "sts:AssumeRole",  
        Principal = {  
          Service = "eks.amazonaws.com"  
        },  
        Effect    = "Allow",  
        Sid       = "",  
      },  
    ],  
  })  
}  

resource "aws_iam_role_policy_attachment" "eks_cluster_role" {  
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"  
  role       = aws_iam_role.eks_role.name  
}  

resource "aws_eks_node_group" "this" {  
  cluster_name    = aws_eks_cluster.this.name  
  node_group_name = "${var.cluster_name}-node-group"  

  node_role_arn   = aws_iam_role.eks_node_role.arn  
  subnet_ids      = var.subnet_ids  

  scaling_config {  
    desired_size = var.eks_managed_node_groups["my_worker_group"]["desired_size"]  
    max_size     = var.eks_managed_node_groups["my_worker_group"]["max_size"]  
    min_size     = var.eks_managed_node_groups["my_worker_group"]["min_size"]  
  }  
}  

output "cluster_endpoint" {  
  value = aws_eks_cluster.this.endpoint  
}  

output "cluster_name" {  
  value = aws_eks_cluster.this.name  
}  

output "cluster_certificate_authority_data" {  
  value = aws_eks_cluster.this.certificate_authority[0].data  
}  
