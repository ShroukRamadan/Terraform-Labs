
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






resource "aws_instance" "instance" {
  ami   = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.subnet.id
  user_data  = file("./userdata.sh")
  vpc_security_group_ids = [aws_security_group.sg.id]
  associate_public_ip_address = true



  tags = {
    Name = "pub-instance"
  }
}

