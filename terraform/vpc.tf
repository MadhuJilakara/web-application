resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "vpc_test"
  }
}

resource "aws_subnet" "PublicSub" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "PublicSub"
  }
}

resource "aws_subnet" "PrivateSub" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "PrivateSub"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "IGW"
  }
}

resource "aws_route_table" "PubRoute" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "PubRoute"
  }
}

resource "aws_route_table" "PrivRoute" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

  tags = {
    Name = "PrivRoute"
  }
}

resource "aws_route_table_association" "PubAssoc" {
  subnet_id      = aws_subnet.PublicSub.id
  route_table_id = aws_route_table.PubRoute.id
}

resource "aws_route_table_association" "PrivAssoc" {
  subnet_id      = aws_subnet.PrivateSub.id
  route_table_id = aws_route_table.PrivRoute.id
}

