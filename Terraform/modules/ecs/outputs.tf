output "ecs_cluster" {
  value = aws_ecs_cluster.ecs_cluster.id
}

output "ecs_task" {
  value = aws_ecs_task_definition.ecs_task.arn
}

output "ecs_iam_role_arn" {
  description = "ARN of the ecs execution role"
  value = aws_iam_role.ecs_iam_role.arn
}

output "ecs_iam_role_name" {
  description = "name of the ecs execution role"
  value = aws_iam_role.ecs_iam_role.name
}