resource "aws_security_group" "rds_sg" {
  name        = "rds_sg"
  description = "Security Group for RDS"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name = "rds-security-group"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_postgres" {
  security_group_id            = aws_security_group.rds_sg.id
  referenced_security_group_id = aws_security_group.asg_sg.id
  from_port                    = 5432
  to_port                      = 5432
  ip_protocol                  = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_egress_rds" {
  security_group_id = aws_security_group.rds_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}