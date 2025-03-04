variable "name" {  
  description = "The name of the VPC"  
  type        = string  
}  

variable "cidr" {  
  description = "The CIDR block for the VPC"  
  type        = string  
}  

variable "azs" {  
  description = "The availability zones for the VPC"  
  type        = list(string)  
}  

variable "private_subnets" {  
  description = "List of private subnet CIDR blocks"  
  type        = list(string)  
}  

variable "public_subnets" {  
  description = "List of public subnet CIDR blocks"  
  type        = list(string)  
}  

variable "enable_nat_gateway" {  
  description = "Enable NAT Gateway"  
  type        = bool  
}  

variable "enable_vpn_gateway" {  
  description = "Enable VPN Gateway"  
  type        = bool  
}  

variable "tags" {  
  description = "Tags for the VPC"  
  type        = map(string)  
}  