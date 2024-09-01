# Output для получения DNS имени Load Balancer
output "lb_dns_name" {
  description = "DNS name of the Load Balancer"
  value       = aws_lb.app_lb.dns_name
}

output "db_host" {
  value = aws_db_instance.postgres.endpoint
  description = "The connection endpoint for the RDS PostgreSQL instance"
}

output "db_port" {
  value = aws_db_instance.postgres.port
  description = "The port for the RDS PostgreSQL instance"
}
