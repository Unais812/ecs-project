# Create VPC
resource "aws_vpc" "ecs_vpc" {
  cidr_block = var.dog
  region = var.cat
  tags = {
    Name = "ecs_vpc"
  }
}

resource "aws_subnet" "public_ecs_subnet_1" {
  vpc_id     = aws_vpc.ecs_vpc.id
  cidr_block = var.public_subnet_cidr_1
  availability_zone = var.az_1

  tags = {
    Name = "public_ecs_subnet_1"
  }
}


resource "aws_subnet" "public_ecs_subnet_2" {
  vpc_id     = aws_vpc.ecs_vpc.id
  cidr_block = var.public_subnet_cidr_2
  availability_zone = var.az_2

  tags = {
    Name = "public_ecs_subnet_2"
  }
}


resource "aws_internet_gateway" "ecs_igw" {
  vpc_id = aws_vpc.ecs_vpc.id

  tags = {
    Name = "ecs_igw"
  }
}


resource "aws_route_table" "ecs_route_table" {
  vpc_id = aws_vpc.ecs_vpc.id

  route {
    cidr_block = var.route_table_cidr
    gateway_id = aws_internet_gateway.ecs_igw.id
  }

  tags = {
    Name = "ecs_route_table"
  }
}

resource "aws_route_table_association" "subnet_association_1" {
  subnet_id    = aws_subnet.public_ecs_subnet_1.id
  route_table_id = aws_route_table.ecs_route_table.id
}

resource "aws_route_table_association" "subnet_association_2" {
  subnet_id    = aws_subnet.public_ecs_subnet_2.id
  route_table_id = aws_route_table.ecs_route_table.id
}