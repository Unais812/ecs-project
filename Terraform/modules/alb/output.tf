output "ecs_sg_alb" {
  value = aws_security_group.ecs_sg_alb.id
}

output "dns_name_alb" {
  value = aws_lb.ecs_alb.dns_name 
}

output "target_group_arn" {
  value = aws_lb_target_group.alb_target_group.arn
}

output "ecs_sg" {
  value = aws_security_group.ecs_sg.id
}

output "load_balancer_arn" {
  value = aws_lb.ecs_alb.arn
}

output "alb_dns" {
  value = aws_lb.ecs_alb.dns_name
}

output "alb_zone_id" {
  value = aws_lb.ecs_alb.zone_id
}