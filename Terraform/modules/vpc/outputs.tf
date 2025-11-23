output "vpc_id" {
    value = aws_vpc.ecs_vpc.id
}

output "subnet1_id" {
    value = aws_subnet.public_ecs_subnet_1.id
}

output "subnet2_id" {
    value = aws_subnet.public_ecs_subnet_2.id 
}

output "ecs_igw_id" {
    value = aws_internet_gateway.ecs_igw.id
}

output "ecs_route_table_id" {
    value = aws_route_table.ecs_route_table.id
}

