resource "aws_alb" "pub-alb" {    
  name  = var.lb-name[0]
  load_balancer_type = var.lb-type
  internal = var.lb-internal[0]
  subnets  = [for pub-subnet in var.pub-subnet : subnet.id]
  
}

resource "aws_alb" "private-lb" {    
  name  = var.lb-name[1]
  load_balancer_type = var.lb-type
  internal = var.lb-internal[1]
  subnets  = [for pub-subnet in var.pub-subnet : subnet.id]
  
}