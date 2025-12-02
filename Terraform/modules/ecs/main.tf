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
    security_groups = [aws_security_group.ecs_sg.id]
    subnets = [var.subnet_id1, var.subnet_id2]
    assign_public_ip = true
  }


  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "latest"
    container_port   = var.port
  }

}


resource "aws_security_group" "ecs_sg" {
  name        = "ecs-sg"
  description = "Allow traffic from container port"
  vpc_id      = var.vpc_id

  tags = {
    Name = "ecs-sg"
  }
}


resource "aws_vpc_security_group_ingress_rule" "ecs-sg-ingress" {
  security_group_id = aws_security_group.ecs_sg.id
  referenced_security_group_id = var.alb_sg
  from_port         = var.app_port
  ip_protocol       = "tcp"
  to_port           = var.app_port
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ecs" {
  security_group_id = aws_security_group.ecs_sg.id
  cidr_ipv4         = var.allow_all_traffic_cidr
  ip_protocol       = "-1" # semantically equivalent to all ports
}
