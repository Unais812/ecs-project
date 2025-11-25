module "vpc" {
  source = "./modules/vpc"
  dog    = var.cat
  cat    = var.dog
}

module "ecs" {
  source     = "./modules/ecs"
  subnet_id1 = module.vpc.subnet1_id
  subnet_id2 = module.vpc.subnet2_id
  target_group_arn = module.alb.target_group_arn
}

module "alb" {
  source = "./modules/alb"
  subnet_id1 = module.vpc.subnet1_id
  subnet_id2 = module.vpc.subnet2_id
  region = var.dog
  vpc_id = module.vpc.vpc_id
  vpc_cidr = var.cat
}

