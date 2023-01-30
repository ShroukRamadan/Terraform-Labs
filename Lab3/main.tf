module "networking"  {

  source = "./Networks"
  vpc-name = "my-vpc"
  vpc-cidr = "10.0.0.0/16"
  pub-subnet-cider =["10.0.0.0/24","10.0.2.0/24"]
  pub-subnet-tag-names = ["pub-subnet-1","pub-subnet-2"]
  private-subnet-cider =["10.0.1.0/24","10.0.3.0/24"]
  private-subnet-tag-names = ["private-subnet-1","private-subnet-2"]
  route-cider = ["0.0.0.0/0" , "::/0"]  
  AZ=["us-east-1a","us-east-1b"]

}


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

  owners = ["099720109477"] 

}

module "servers" {

  source = "./Servers" 
  ami  = data.aws_ami.ubuntu.id
  instace-type = "t2.micro"
  count = length(module.networking.pub-subnets-ids) 
  pub-instance-tag-name = ["proxy-1","proxy-2"]
  private-instance-tag-name = ["private-ec2-1","private-ec2-2"]
  key-name = "iti-ssh"
  vpc-id = module.networking.vpc-id
  pub-subnets = module.networking.pub-subnet.pub-subnets-ids[count.index]
  private-subnets = module.networking.pub-subnet.private-subnets-ids[count.index]

  private-lb-dns=module.lb.private-dns-lb

 
}

module "lb" { 
  
  source = "./Loadbalabncer"
  lb-tag-name = ["pub-Alb","private-Alb"]
  lb-type = "Application"
  internal = ["false","true"]
  vpc-id=module.networking.vpc-id
  pub-subnets=module.networking.pub-subnets-ids
  private-subnets=module.networking.private-subnets-ids
  
  pub-instance-id=module.servers.pub-instaces-ids
  private-instance-id=module.servers.private-instaces-ids

}