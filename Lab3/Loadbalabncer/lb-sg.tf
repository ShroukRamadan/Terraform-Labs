resource "aws_security_group" "PubLB-sg" {
  name        = "PublicALB_sg"
  description = "allow ssh on 22 & http on port 80"
  vpc_id      = var.vpc-id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "private-lb-sg" {
  name        = "privateALB_sg"
  description = "allow ssh on 22 & http on port 80 "
  vpc_id      = var.vpc-id

  ingress {
    from_port                = 22
    to_port                  = 22
    protocol                 = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
 

  ingress {
    from_port                = 80
    to_port                  = 80
    protocol                 = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}