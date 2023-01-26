resource "aws_alb_target_group" "pub-tg-group" {  

  name     = "pub-alb-target"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc-id
  target_type = "instance"      
} 

resource "aws_lb_target_group_attachment" "pub-attach-instance" {
 
    target_group_arn = var.pub-tg-arn
    target_id        = var.pub-instance-id
    port             = 80
    
}


resource "aws_lb_listener" "pub-alb-listener" {

  load_balancer_arn = var.pub-lb-arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = var.private-lb-arn
  }

}
