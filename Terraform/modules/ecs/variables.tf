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
    default = "ecs-project" 
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