output "ecs_sg_alb" {
  value = aws_security_group.ecs_sg_alb.id
}

output "dns_name_alb" {
  value = aws_lb.ecs_alb.dns_name 
}

output "target_group_arn" {
  value = aws_lb_target_group.alb_target_group.arn
}
