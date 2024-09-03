locals {
  vars = {
    rdsendpoint = aws_db_instance.postgres.address
    DBName      = var.DBName
    DBPassword  = var.DBPassword
    DBUser      = var.DBUser
    HELLO_WORLD = "Hello world!"
  }
}
