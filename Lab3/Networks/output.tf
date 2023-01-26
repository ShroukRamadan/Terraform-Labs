output "vpc-id" {
  value= aws_vpc.vpc.id
}

output "pub-subnets-ids" {
  value= toset(aws_subnet.pub-subnet.id)
}

output "private-subnets-id" {
  value = toset(aws_subnet.private-subnet.id)
}










