resource "aws_security_group" "pub-sg" {  
  name        = "http-sg"
  description = "allow http on port 80"
  vpc_id = aws_vpc.vpc.vpc-id

  ingress {
    from_port        = 22
    to_port          = 22
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


resource "aws_security_group" "private-lb" {

  name        = "private-lb"
  description = "allow http on port 80"
  vpc_id = aws_vpc.vpc.vpc-id
  
  ingress{

  from_port              = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = var.alb_sg_id
  security_group_id        = aws_security_group.pub-sg.id

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  
}