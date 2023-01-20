

variable "vpc-cidr" {
    description = "this variable is cider for vpc"
    type = string   
}

variable "subnet-cider" {
  description = "this variable is cider for subnet"
  type= list

}


variable "subnet-tag-name" {
  type= list
}

variable "route-cider" {
  type = list
}

variable "instace-type" {
    type = string
}

variable "user-data" {
    type = string
}

variable "key-name" {
  type = string
}