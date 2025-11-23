variable "dog" {
    description = "cidr for the vpc"
    type = string
    # default = "10.0.0.0/24"
}

variable "cat" {
    description = "region"
    type = string
    # default = "eu-north-1"
}

variable "public_subnet_cidr_1" {
    description = "The cidr for public subnet 1"
    type = string
    default = "10.0.0.128/26"
}


variable "public_subnet_cidr_2" {
    description = "The cidr for public subnet 2"
    type = string
    default = "10.0.0.192/26"
}


variable "az_1" {
    description = "az for first subnet"
    type = string
    default = "eu-north-1a"
}

variable "az_2" {
    description = "az for second subnet"
    type = string
    default = "eu-north-1b"
}

variable "route_table_cidr" {
    description = "cidr for route table"
    type = string
    default = "0.0.0.0/0"
}
