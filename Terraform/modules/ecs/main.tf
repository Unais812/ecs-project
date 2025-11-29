resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.ecs_cluster_name
}


resource "aws_cloudwatch_log_group" "cw_log_group" {
  name              = var.log_group_name
  retention_in_days = var.log_days
}

resource "aws_ecs_task_definition" "ecs_task" {
  family = "ecs_task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.task_definiton_cpu
  memory                   = var.task_definition_memory
  execution_role_arn = aws_iam_role.ecs_iam_role.arn
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

       logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"       = aws_cloudwatch_log_group.cw_log_group.name
          awslogs-region        = var.region
          awslogs-stream-prefix = var.logstream_prefix

        }
       }
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
        Effect = "Allow"
        Action = "sts:AssumeRole"
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

resource "aws_iam_role_policy_attachment" "ecs-full-access-attach" {
  role       = aws_iam_role.ecs_iam_role.name
  policy_arn = var.arn_ecs_full_access
}




resource "aws_ecs_service" "ecs_service" {
  name            = "ecs_service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.ecs_task.arn
  desired_count   = 2
  launch_type = "FARGATE"


  network_configuration {
    security_groups = [var.ecs_sg]
    subnets = [var.subnet_id1, var.subnet_id2]
  }


  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "latest"
    container_port   = var.port
  }

}



