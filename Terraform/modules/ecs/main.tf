resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.ecs_cluster_name
}

resource "aws_ecs_task_definition" "ecs_task" {
  family = "ecs_task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.task_definiton_cpu
  memory                   = var.task_definition_memory
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "ARM64"
  }
  container_definitions = jsonencode([
    {
      name      = var.image_name
      image     = var.image
      
      portMappings = [
        {
          containerPort = var.port
          protocol = "tcp"
        }
      ]
    }
    
  ])
}


resource "aws_iam_role" "ecs_iam_role" {
  name = "ecs_task_iam"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name = "task-execution-role-ecs"
  }
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.ecs_iam_role.name
  policy_arn = var.arn_execution_task
}



resource "aws_ecs_service" "ecs_service" {
  name            = "ecs_service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.ecs_task.arn
  desired_count   = 2
  iam_role        = aws_iam_role.ecs_iam_role.arn
  
  network_configuration {
    subnets = [var.subnet_id1, var.subnet_id2]
  }


  load_balancer {
    target_group_arn = aws_lb_target_group.foo.arn
    container_name   = "ecs-project"
    container_port   = var.port
  }

}


