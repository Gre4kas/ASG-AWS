# Security Group для EC2
resource "aws_security_group" "asg_sg" {
  name        = "asg_sg"
  description = "Security Group for ASG"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name = "ec2-security-group"
  }
}


resource "aws_vpc_security_group_ingress_rule" "allow_ssh_asg" {
  security_group_id = aws_security_group.asg_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_asg" {
  security_group_id = aws_security_group.asg_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_egress_asg" {
  security_group_id = aws_security_group.asg_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
