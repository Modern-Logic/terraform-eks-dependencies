module "redis_security_group" {
  source              = "github.com/Modern-Logic/terraform-modules.git//simple/vpc_security_group?ref=v1.0"
  environment         = var.environment
  company_name        = var.company_name
  tags                = var.tags
  security_group_name = "redis-eks"
  vpc_id              = local.vpc_id
  ingress_rules       = var.elasticache_redis_security_group_rules
}

module "redis" {
  source             = "github.com/Modern-Logic/terraform-modules.git//simple/redis?ref=v1.0"
  environment        = var.environment
  company_name       = var.company_name
  name               = "redis"
  tags               = var.tags
  security_group_ids = [module.redis_security_group.security_group_id]
  subnet_ids         = local.private_subnet_ids
  node_type          = var.redis_node_type
}
