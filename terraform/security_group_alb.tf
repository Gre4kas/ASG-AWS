# Security Group for lb
resource "aws_security_group" "lb_sg" {
  name        = "lb_sg"
  description = "Security Group for lb"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name = "lb-security-group"
  }
}


resource "aws_vpc_security_group_ingress_rule" "allow_http_lb" {
  security_group_id = aws_security_group.lb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "allow_https_lb" {
  security_group_id = aws_security_group.lb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_egress_lb" {
  security_group_id = aws_security_group.lb_sg.id
  cidr_ipv4         = var.cidr_block
  ip_protocol       = "-1"
}
