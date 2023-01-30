resource "aws_lb" "pub-lb" {
  name               = var.lb-name[0]
  internal           = var.lb-internal[0]
  load_balancer_type = var.lb-type
  security_groups    = [aws_security_group.PubLB-sg.id]
  subnets            = var.pub-subnets 

}

resource "aws_lb_listener" "PublicLBlistener" {
  load_balancer_arn = aws_lb.pub-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.pub-tg.arn
  }
}


resource "aws_lb" "private-lb" {
  name               = var.lb-name[1]
  internal           = var.lb-internal[1]
  load_balancer_type = var.lb-type
  security_groups    = [aws_security_group.private-lb-sg.id]
  subnets            = var.private-subnets

}



resource "aws_lb_listener" "PrivateLBlistener" {
  load_balancer_arn = aws_lb.private-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.private-tg.arn
  }
}
