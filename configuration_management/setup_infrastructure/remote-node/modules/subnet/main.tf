resource "aws_subnet" "infra-subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = var.subnet_cidr_block
  availability_zone = var.az
  tags = {
    Name = "${var.env_prefix}-subnet"
  }
}

resource "aws_internet_gateway" "infra-internet-gateway" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.env_prefix}:infra-vpc/igw"
  }
}

resource "aws_default_route_table" "my-app-default-route-table" {
  default_route_table_id = var.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.infra-internet-gateway.id
  }

  tags = {
    Name = "${var.env_prefix}:infra-vpc/default-rtb"
  }
}