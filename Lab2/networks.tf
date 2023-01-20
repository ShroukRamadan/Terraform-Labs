resource "aws_vpc" "vpc" {
  cidr_block    =var.vpc-cidr

  tags = {
    Name = "my-vpc"
  }
  
}

resource "aws_subnet" "subnet" {
  count = length(var.subnet-cider)
  cidr_block = var.subnet-cider[count.index]
  vpc_id     = aws_vpc.vpc.id
  availability_zone = "us-east-1a"

  tags = {
    Name = var.subnet-tag-name[count.index]
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "igw-id"
  }
}


resource "aws_eip" "e-ip" {
  vpc = true
}

resource "aws_nat_gateway" "nat-gw" {
  subnet_id= aws_subnet.subnet[0].id
  allocation_id = aws_eip.e-ip.id
  

  tags = {
    Name = "my-nat"
  }
}
  

resource "aws_route_table" "pub-rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.route-cider[0]
    gateway_id = aws_internet_gateway.gw.id
  }
  
  route {
    ipv6_cidr_block   = var.route-cider[1]
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "pub-rt"
  }

}



resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.route-cider[0]
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }
  
 
  tags = {
    Name = "private-rt"
  }

}

resource "aws_route_table_association" "pub" {
  subnet_id      = aws_subnet.subnet[0].id
  route_table_id = aws_route_table.pub-rt.id
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.subnet[1].id
  route_table_id = aws_route_table.private-rt.id
}


