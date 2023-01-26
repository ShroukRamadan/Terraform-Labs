variable "vpc-cidr" {
    type = string   
}

variable "vpc-name" {
  type = string
  
}


variable "pub-subnet-cider" {
  type= list

}

variable "private-subnet-cider" {
  type= list

}

variable "pub-subnet-tag-names" {
  type= list
}

variable "private-subnet-tag-names" {
  type= list
}

variable "AZ" {
  type = list
}

variable "route-cider" {
  type = list
}


