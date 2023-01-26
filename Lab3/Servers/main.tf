resource "aws_instance" "pub-instance" {
  
  count = length(var.pub-subnets)
  ami   = var.ami
  instance_type = var.instace-type
  subnet_id = var.pub-subnets
  key_name  = var.key-name
  vpc_security_group_ids = [aws_security_group.instace-sg.id]
  associate_public_ip_address = true
  tags = {
    Name = var.pub-instance-tag-name[count.index]
  
  }

  provisioner "remote-exec" {
  
    inline = [       
       "sudo apt update -y",
       "sudo apt install nginx -y",
       "sudo systemctl enable --now nginx",
       "sudo systemctl status nginx"

    ]
  }

  connection {
    type     = "ssh"
    user     = "ubuntu"
    host     = self.public_ip
    private_key = file("./iti-ssh.pem")
  }


}


resource "aws_instance" "private-instance" {
  
  count = length(var.private-subnets)
  ami   = var.ami
  instance_type = var.instace-type
  subnet_id = var.private-subnets

  key_name  = var.key-name
  vpc_security_group_ids = [aws_security_group.instace-sg.id]
  

  tags = {
    Name = var.private-instance-tag-name[count.index]
  }


    provisioner "remote-exec" {
  
    inline = [
       
       "sudo apt update -y",
       "sudo apt install nginx -y",
       "sudo systemctl enable --now nginx",
       "sudo systemctl status nginx",
       " echo  Hello from Private Instance with ip = $(hostname -f)  > /var/www/html/index.html "

    ]
  }
  
  connection {
    type     = "ssh"
    user     = "ubuntu"
  }
  

}


