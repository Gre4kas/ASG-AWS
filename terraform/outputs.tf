# Output для получения DNS имени Load Balancer
output "lb_dns_name" {
  description = "DNS name of the Load Balancer"
  value       = aws_lb.app_lb.dns_name
}
