output "pub-instance_id" {
  value =toset(aws_instance.pub-instance.id)
}

output "private-instance-id" {
  value =toset(aws_instance.private-instance.id)
}

output "pub-instace-pub-ip" {
    value =toset(aws_instance.pub-instance.public_ip)
}

output "pub-instance-private-ip" {
      value =toset(aws_instance.private-instance.private_ip)

}

output "private-instance-private-ip" {
      value =toset(aws_instance.private-instance.private_ip)

}


