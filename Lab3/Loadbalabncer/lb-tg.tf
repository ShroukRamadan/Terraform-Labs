
resource "aws_lb_target_group" "pub-tg" {
  name     = "pub-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc-id
}

resource "aws_lb_target_group_attachment" "pub-attach-instances" {
  count = length(var.pub-instances-ids)
  target_group_arn = aws_lb_target_group.pub-tg.arn
  target_id        = var.public-instances-ids[count.index]
  port             = 80
}


#------------------------------------------------------------------------------------------------------



resource "aws_lb_target_group" "private-tg" {
  name     = "private-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc-id
}

resource "aws_lb_target_group_attachment" "private-attach-instances" {
  count = length(var.private-instances-ids)
  target_group_arn = aws_lb_target_group.private-tg.arn
  target_id        = var.private-instances-ids[count.index]
  port             = 80
}
