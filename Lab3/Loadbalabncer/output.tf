
output "pub-tg-arn" {
    value=aws_lb_target_group.tg-attach-instance.arn
  
}

output "pub-lb-arn" {
    value=aws_lb.pub-alb.arn
 
}

output "private-lb-arn" {
        value=aws_lb.private-alb.arn

  
}


output "private-dns-lb" {
  value = "https://${aws_alb.private-lb.dns_name}"
}