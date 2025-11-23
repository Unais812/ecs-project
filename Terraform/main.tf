module "vpc" {
  source = "./modules/vpc"
  dog    = var.cat
  cat = var.dog
}