output "pub-tg-arn" {
    value=aws_lb_target_group.pub-tg.arn
  
}

output "private-tg-arn" {
    value=aws_lb_target_group.private-tg.arn

}
output "pub-lb-arn" {
    value=aws_lb.pub-alb.arn
 
}

output "private-lb-arn" {
        value=aws_lb.private-alb.arn

  
}


output "private-dns-lb" {
  value = aws_alb.private-lb.dns_name
}