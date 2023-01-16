data "aws_ami" "ubuntu" {
  most_recent = true

}




resource "aws_network_interface" "net-interface" {
  subnet_id   = aws_subnet.subnet.id
  private_ips = ["10.0.0.0"]

  tags = {
    Name = "primary_network_interface"
  }
}



resource "aws_instance" "instance" {
  ami   = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = file("./iti-ssh.pem")
  user_data  = file("./userdata.txt")
  vpc_security_group_ids = [aws_security_group.sg.id]



  tags = {
    Name = "pub-instance"
  }
}


output "aws_instance_public_dns" {
  value = aws_instance.instance.public_dns
}
