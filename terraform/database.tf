# Создание RDS PostgreSQL
resource "aws_db_instance" "postgres" {
  allocated_storage            = 10
  db_name                      = "mydatabase"
  engine                       = "postgres"
  engine_version               = "16.4"
  instance_class               = "db.t3.micro"
  username                     = "foo"
  password                     = "foobarbaz"
  parameter_group_name         = "default.postgres16"
  skip_final_snapshot          = true
  publicly_accessible          = false # for prod need false
  storage_encrypted            = true
  vpc_security_group_ids       = [aws_security_group.rds_sg.id]
  db_subnet_group_name         = aws_db_subnet_group.main.name
  copy_tags_to_snapshot        = true
  multi_az                     = true
  performance_insights_enabled = true
  monitoring_interval          = 5
  
  tags = {
    Name = "my-postgres-db"
  }
}

# Создание DB Subnet Group для RDS
resource "aws_db_subnet_group" "main" {
  name       = "main-subnet-group"
  subnet_ids = module.vpc.private_subnets
  tags = {
    Name = "main-db-subnet-group"
  }
}