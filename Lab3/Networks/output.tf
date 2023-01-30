output "vpc-id" {
  value= aws_vpc.vpc.id
}

output "pub-subnets-ids" {
  value = [for subnet in aws_subnet.pub-subnets : subnet.id]
  
}

output "private-subnets-id" {
  value = [for subnet in aws_subnet.private-subnets : subnet.id]
}










