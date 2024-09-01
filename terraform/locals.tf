locals {
  vars = {
    rdsendpoint = aws_rds
    DBName = var.DBName
    DBPassword = var.DBPassword
    DBUser = var.DBUser
  }
}
