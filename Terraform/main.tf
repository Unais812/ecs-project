module "vpc" {
  source = "./modules/vpc"
  dog    = var.cat
  cat    = var.dog
}

module "ecs" {
  source            = "./modules/ecs"
  subnet_id1        = module.vpc.subnet1_id
  subnet_id2        = module.vpc.subnet2_id
  target_group_arn  = module.alb.target_group_arn
  ecs_sg            = module.alb.ecs_sg
  load_balancer_arn = module.alb.load_balancer_arn
}

module "alb" {
  source     = "./modules/alb"
  subnet_id1 = module.vpc.subnet1_id
  subnet_id2 = module.vpc.subnet2_id
  region     = var.dog
  vpc_id     = module.vpc.vpc_id
  vpc_cidr   = var.cat
  cert_arn = module.route53.cert_arn
}

module "route53" {
  source      = "./modules/route53"
  alb_dns     = module.alb.alb_dns
  alb_zone_id = module.alb.alb_zone_id
}



