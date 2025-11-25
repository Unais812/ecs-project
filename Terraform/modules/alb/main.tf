resource "aws_lb" "ecs_alb" {
  name               = "ecs-alb"
  region = var.region
  internal           = false
  security_groups    = [aws_security_group.ecs_sg_alb.id]
  subnets            = [var.subnet_id1, var.subnet_id2]

  enable_deletion_protection = true

  tags = {
    Name = "ecs_alb"
  }
}


resource "aws_lb_target_group" "alb_target_group" {
  name     = "alb-target-group"
  port     = var.app_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  
  health_check {
    path = var.health_path
    interval = var.health_interval
    matcher = var.health_matcher
    timeout = var.health_timeout
    healthy_threshold = var.health_threshold
    unhealthy_threshold = var.health_unhealthy_threshold
  }
}


resource "aws_security_group" "ecs_sg_alb" {
  name        = "ecs_sg_slb"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "ecs_sg_alb"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.ecs_sg_alb.id
  cidr_ipv4         = var.vpc_cidr
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.ecs_sg_alb.id
  cidr_ipv4         = var.vpc_cidr
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}





