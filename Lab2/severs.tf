data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical

}


resource "aws_instance" "pub-instance" {
  ami   = data.aws_ami.ubuntu.id
  instance_type = var.instace-type
  subnet_id = aws_subnet.subnet[0].id
  key_name  = var.key-name
  user_data  = file(var.user-data)
  vpc_security_group_ids = [aws_security_group.pub-sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "pub-instance"
  }
}

resource "aws_instance" "private-instance" {
  ami   = data.aws_ami.ubuntu.id
  instance_type = var.instace-type
  subnet_id = aws_subnet.subnet[1].id
  key_name  = var.key-name
  user_data  = file(var.user-data)
  vpc_security_group_ids = [aws_security_group.pub-sg.id]
  

  tags = {
    Name = "private-instance"
  }
}

