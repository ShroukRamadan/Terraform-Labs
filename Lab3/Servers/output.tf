output "pub-instances-ids" {
  value =aws_instance.pub-instance
}

output "private-instances-ids" {
  value =aws_instance.private-instance
}

output "pub-instace-pub-ip" {
    value =aws_instance.pub-instance.public_ip
}

output "pub-instance-private-ip" {
      value =aws_instance.private-instance.private_ip

}

output "private-instance-private-ip" {
      value =aws_instance.private-instance.private_ip

}

output "instace-sg-id" {
  
  value = aws_security_group.instace-sg.id
}


