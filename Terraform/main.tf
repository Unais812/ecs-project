module "vpc" {
  source = "./modules/vpc"
}

module "ecs" {
  source            = "./modules/ecs"
  subnet_id1        = module.vpc.subnet1_id
  subnet_id2        = module.vpc.subnet2_id
  target_group_arn  = module.alb.target_group_arn
  load_balancer_arn = module.alb.load_balancer_arn
  vpc_id     = module.vpc.vpc_id
  alb_sg = module.alb.ecs_sg_alb
}

module "alb" {
  source     = "./modules/alb"
  subnet_id1 = module.vpc.subnet1_id
  subnet_id2 = module.vpc.subnet2_id
  cert_arn = module.route53.cert_arn
   vpc_id     = module.vpc.vpc_id
}

module "route53" {
  source      = "./modules/route53"
  alb_dns     = module.alb.alb_dns
  alb_zone_id = module.alb.alb_zone_id
}



