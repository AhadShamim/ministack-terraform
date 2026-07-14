module "database" {
  source      = "./modules/rds_postgres"
  db_password = var.db_password
}

module "backend" {
  source      = "./modules/ecs_backend"
  db_host     = element(split(":", module.database.db_endpoint), 0)
  db_password = var.db_password
}

module "frontend" {
  source = "./modules/s3_frontend"
}
