resource "aws_security_group" "pub-sg" {
  name        = "http&&ssh_sg"
  description = "allow ssh on 22 & http on port 80"
  vpc_id = aws_vpc.vpc.id


  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}



# resource "aws_security_group" "private-sg" {
#   name        = "private-sg"
#   description = "allow http only"
#   vpc_id = aws_vpc.vpc.id


#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }
# }
