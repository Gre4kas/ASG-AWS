resource "aws_route_table" "public_rt" {
  vpc_id = module.vpc.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public_association" {
  subnet_id      = module.vpc.public_subnets[0]
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table" "private_rt" {
  vpc_id = module.vpc.vpc_id
  tags = {
    Name = "private-route-table"
  }
}

resource "aws_route_table_association" "private_association" {
  subnet_id      = module.vpc.private_subnets[0]
  route_table_id = aws_route_table.private_rt.id
}