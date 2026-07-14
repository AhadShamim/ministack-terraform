resource "aws_db_instance" "postgres" {
  identifier           = "rds-db"
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "15"
  instance_class       = "db.t3.micro"
  db_name              = "mydb"
  username             = "admin"
  password             = var.db_password
  skip_final_snapshot  = true
}