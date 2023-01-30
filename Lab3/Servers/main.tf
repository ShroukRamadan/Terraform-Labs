resource "aws_instance" "pub-instance" {  
  ami   = var.ami
  instance_type = var.instace-type
  subnet_id = var.pub-subnets
  key_name  = var.key-name
  vpc_security_group_ids = var.instace-sg
  associate_public_ip_address = true
  tags = {
    Name = var.pub-instance-tag-name[count.index]
  
  }

  provisioner "local-exec" {
     command= "echo 'private IP is ${self.private_ip} & public IP is ${self.public_ip}' >> all-ips.txt"
  }

  provisioner "remote-exec" {
  
    inline = [       
       "sudo apt update -y",
       "sudo apt install nginx -y",
       "sudo systemctl enable --now nginx",
       "sudo systemctl status nginx",
       "sudo echo 'server { \n listen 80 default_server; \n  listen [::]:80 default_server; \n  server_name _; \n  location / { \n  proxy_pass http://${var.private-lb-dns}; \n  } \n}' > default",
       "sudo mv default /etc/nginx/sites-enabled/default",
       "sudo systemctl restart nginx",

    ]
  }

  connection {
    type     = "ssh"
    user     = "ubuntu"
    host     = self.public_ip
    private_key = file("./iti-ssh.pem")
    timeout     = "4m"
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

    provisioner "local-exec" {
     command= "echo 'private IP is ${self.private_ip}  >> all-ips.txt"
  }
    provisioner "remote-exec" {
  
    inline = [
       
       "sudo apt update -y",
       "sudo apt install nginx -y",
       "sudo systemctl enable --now nginx",
       "sudo systemctl status nginx",
       "echo Hello from Private Instance with ip = $(hostname -f)  > /var/www/html/index.html "

    ]
  }
  
  connection {
    type     = "ssh"
    user     = "ubuntu"
    host     = self.private_ip
    timeout     = "4m"

    bastion_host = var.pub-instace-pub-ip
    bastion_user =   "ubuntu"
    bastion_host_key =  file("./iti-ssh.pem")
  }
  

}


