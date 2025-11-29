variable "subnet_id1" {
  description = "id of the first subnet"
  type = string
}

variable "subnet_id2" {
  description = "id of the second subnet"
  type = string
}

variable "region" {
    description = "the region for the alb"
    type = string
}

variable "vpc_id" {
    description = "id for the vpc"
    type = string
}

variable "vpc_cidr" {
    description = "cidr for the vpc which is required for the security group"
    type = string
}

variable "app_port" {
    description = "port which the application is listening on"
    type = number
    default = 3000
}

variable "health_path" {
    description = "path for the health check for the target group"
    type = string
    default = "/"
}

variable "health_interval" {
    description = "the interval for the health check"
    type = number
    default = 50
}

variable "health_matcher" {
    description = "matcher for the health check"
    type = number
    default = 200
}

variable "health_threshold" {
  description = "the threshold for the health check"
  type = number
  default = 3
}

variable "health_unhealthy_threshold" {
  description = "the number of health check failure "
  type = number
  default = 3
}

variable "health_timeout" {
  description = "timeout for the health check"
  type = number
  default = 6
}

variable "allow_all_traffic_cidr" {
  description = "allow all inbound traffic"
  type = string
  default = "0.0.0.0/0"
}

variable "ssl_policy" {
  description = "ssl policy"
  type = string
  default = "ELBSecurityPolicy-2016-08"
}

variable "cert_arn" {
  description = "arn of the certficate"
  type = string
}