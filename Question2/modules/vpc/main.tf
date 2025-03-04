resource "aws_vpc" "this" {  
  cidr_block = var.cidr  
  enable_dns_support = true  
  enable_dns_hostnames = true  
  tags = {  
    Name = var.name  
  }  
}  

resource "aws_subnet" "private" {  
  count                   = length(var.private_subnets)  
  vpc_id                  = aws_vpc.this.id  
  cidr_block              = var.private_subnets[count.index]  
  availability_zone       = element(var.azs, count.index)  
  map_public_ip_on_launch = false  

  tags = {  
    Name = "${var.name}-private-${count.index + 1}"  
  }  
}  

resource "aws_subnet" "public" {  
  count                   = length(var.public_subnets)  
  vpc_id                  = aws_vpc.this.id  
  cidr_block              = var.public_subnets[count.index]  
  availability_zone       = element(var.azs, count.index)  
  map_public_ip_on_launch = true  

  tags = {  
    Name = "${var.name}-public-${count.index + 1}"  
  }  
}  

output "vpc_id" {  
  value = aws_vpc.this.id  
}  

output "private_subnets" {  
  value = aws_subnet.private[*].id  
}  

output "public_subnets" {  
  value = aws_subnet.public[*].id  
}  
