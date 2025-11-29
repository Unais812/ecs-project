resource "aws_lb" "ecs_alb" {
  name               = "ecs-alb"
  region = var.region
  internal           = false
  security_groups    = [aws_security_group.ecs_sg_alb.id]
  subnets            = [var.subnet_id1, var.subnet_id2]

  tags = {
    Name = "ecs_alb"
  }
}


resource "aws_lb_target_group" "alb_target_group" {
  name     = "alb-target-group"
  target_type = "ip"
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


# Configure the redirect action from HTTP to HTTPS omce route 53 is set up with ssl cert
resource "aws_lb_listener" "redirct-HTTPS" {
  load_balancer_arn = aws_lb.ecs_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }    
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.ecs_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.cert_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn

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
  cidr_ipv4         = var.allow_all_traffic_cidr
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.ecs_sg_alb.id
  cidr_ipv4         = var.allow_all_traffic_cidr
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.ecs_sg_alb.id
  cidr_ipv4         = var.allow_all_traffic_cidr
  ip_protocol       = "-1" # semantically equivalent to all ports
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
  referenced_security_group_id = aws_security_group.ecs_sg_alb.id
  from_port         = var.app_port
  ip_protocol       = "tcp"
  to_port           = var.app_port
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ecs" {
  security_group_id = aws_security_group.ecs_sg.id
  cidr_ipv4         = var.allow_all_traffic_cidr
  ip_protocol       = "-1" # semantically equivalent to all ports
}

