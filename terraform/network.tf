resource "aws_vpc" "dishare-vpc" {
  cidr_block                       = "10.0.0.0/16"
  instance_tenancy                 = "default"
  enable_dns_support               = true
  enable_dns_hostnames             = true
  tags = {
    Name = "dishare-vpc"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_subnet" "dishare-public-sb-1a" {
  vpc_id     = aws_vpc.dishare-vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-northeast-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "dishare-public-sb-1a"
  }
}
resource "aws_subnet" "dishare-private-sb-1a" {
  vpc_id     = aws_vpc.dishare-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-northeast-1a"
  tags = {
    Name = "dishare-private-sb-1a"
  }
}
resource "aws_subnet" "dishare-public-sb-1c" {
  vpc_id     = aws_vpc.dishare-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-northeast-1c"
  map_public_ip_on_launch = true
  tags = {
    Name = "dishare-public-sb-1c"
  }
}
resource "aws_subnet" "dishare-private-sb-1c" {
  vpc_id     = aws_vpc.dishare-vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "ap-northeast-1c"
  tags = {
    Name = "dishare-private-sb-1c"
  }
}

resource "aws_db_subnet_group" "dishare-rds-subnet-group" {
  name        = "dishare_rds_subnet_group"
  description = "rds subnet group for dishare"
  subnet_ids  = [aws_subnet.dishare-private-sb-1a.id, aws_subnet.dishare-private-sb-1c.id]
}

resource "aws_internet_gateway" "dishare-ig" {
  vpc_id = aws_vpc.dishare-vpc.id
  tags = {
    Name = "dishare-ig"
  }
}

resource "aws_eip" "dishare-nat-eip" {
  vpc = true
  depends_on = [aws_internet_gateway.dishare-ig]
}

resource "aws_nat_gateway" "dishare-nat" {
  allocation_id = aws_eip.dishare-nat-eip.id
  subnet_id = aws_subnet.dishare-public-sb-1a.id
  depends_on = [aws_internet_gateway.dishare-ig]
}

resource "aws_route_table" "dishare-public-route-table" {
  vpc_id = aws_vpc.dishare-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dishare-ig.id
  }
  tags = {
    Name = "dishare-public-route-table"
  }
}

resource "aws_route_table" "dishare-private-route-table" {
  vpc_id = aws_vpc.dishare-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.dishare-nat.id
  }
  tags = {
    Name = "dishare-private-route-table"
  }
}

resource "aws_route_table_association" "dishare-sb-rtb-public-1a" {
  subnet_id      = aws_subnet.dishare-public-sb-1a.id
  route_table_id = aws_route_table.dishare-public-route-table.id
}
resource "aws_route_table_association" "dishare-sb-rtb-public-1c" {
  subnet_id      = aws_subnet.dishare-public-sb-1c.id
  route_table_id = aws_route_table.dishare-public-route-table.id
}
resource "aws_route_table_association" "dishare-sb-rtb-private-1a" {
  subnet_id      = aws_subnet.dishare-private-sb-1a.id
  route_table_id = aws_route_table.dishare-private-route-table.id
}
resource "aws_route_table_association" "dishare-sb-rtb-private-1c" {
  subnet_id      = aws_subnet.dishare-private-sb-1c.id
  route_table_id = aws_route_table.dishare-private-route-table.id
}