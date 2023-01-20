output "pubEc2-pub-ip" {
  value= aws_instance.pub-instance.public_ip
}

output "pubEc2-private-ip" {
  value= aws_instance.pub-instance.private_ip
}

output "privateEc2-ip" {
  value= aws_instance.private-instance.private_ip
}