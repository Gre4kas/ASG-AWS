# Создание RDS PostgreSQL
resource "aws_db_instance" "postgres" {
  allocated_storage            = 10
  db_name                      = var.DBName
  engine                       = "postgres"
  engine_version               = "16.4"
  instance_class               = var.db_instance_class
  username                     = var.DBUser
  password                     = var.DBPassword
  skip_final_snapshot          = true
  backup_retention_period      = 1
  publicly_accessible          = false # for prod need false
  storage_encrypted            = false
  vpc_security_group_ids       = [aws_security_group.rds_sg.id]
  db_subnet_group_name         = aws_db_subnet_group.main.name
  copy_tags_to_snapshot        = true
  multi_az                     = false
  performance_insights_enabled = false

  monitoring_interval = 0

  deletion_protection = false

  tags = {
    Name = "my-postgres-db"
  }
}

# Создание DB Subnet Group для RDS
resource "aws_db_subnet_group" "main" {
  name       = "main-subnet-group"
  subnet_ids = module.vpc.database_subnets
  tags = {
    Name = "main-db-subnet-group"
  }
}