variable "cluster_name" {  
  description = "Name of the EKS cluster"  
  type        = string  
}  

variable "subnet_ids" {  
  description = "List of subnet IDs for the EKS cluster"  
  type        = list(string)  
}  

variable "eks_managed_node_groups" {  
  description = "EKS managed node groups configuration"  
  type        = map(object({  
    desired_size = number  
    max_size     = number  
    min_size     = number    
  }))  
}  

variable "node_role_arn" {  
  description = "Role ARN for the EKS nodes"  
  type        = string  
}  

variable "cluster_endpoint" {  
  description = "EKS Cluster endpoint"  
  type        = string  
}  