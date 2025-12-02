variable "ecs_cluster_name" {
    description = "name for the ecs cluster"
    type = string
    default = "ecs_cluster"
  
}


variable "task_definiton_cpu" {
    description = "cpu required for the task definition"
    type = number
    default = 256 
}

variable "task_definition_memory" {
    description = "memory required for the task definitions"
    type = number
    default = 512
}

variable "image" {
    description = "Docker image for the ecs cluster"
    type = string
    default = "801822495646.dkr.ecr.eu-north-1.amazonaws.com/ecs-project:latest" 
}


variable "image_name" {
    description = "name of the Docker image"
    type = string
    default = "latest" 
}

variable "port" {
    description = "Ports for the container and app"
    type = number
    default = 3000
}



variable "arn_execution_task" {
    description = "arn for the ecs execution task"
    type = string
    default = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

variable "subnet_id1" {
    description = "id of first subnet"
    type = string
}

variable "subnet_id2" {
    description = "id of the second subnet"
    type = string
}

variable "target_group_arn" {
    description = "arn of the target group to reference for the load balancer in ecs service"
    type = string
}

variable "ecs_task_iam" {
  default = "ecs_task_iam"
}

variable "load_balancer_arn" {
  description = "arn for the alb to configure the listener"
  type = string
}

variable "log_group_name" {
  description = "group name for cloudwatch"
  type = string
  default = "ecs-logs"
}

variable "log_days" {
  description = "retention in days for cloudwatch logs"
  type = number
  default = 7
}

variable "region" {
  description = "region for cloudwatch"
  type = string
  default = "eu-north-1"
}

variable "logstream_prefix" {
  description = "logstream prefix"
  type        = string
  default     = "ecs"
}

variable "arn_ecs_full_access" {
  description = "grants role full access for ecs service"
  type = string
  default = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
}

variable "app_port" {
  description = "port which my app is hosted on"
  type = number
  default = 3000
}

variable "allow_all_traffic_cidr" {
  description = "cidr to allow all traffic"
  type = string
  default = "0.0.0.0/0"
}

variable "vpc_id" {
    description = "id for the vpc"
    type = string
}

variable "alb_sg" {
  description = "id of the alb sg"
  type = string
}
