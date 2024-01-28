#Provisioning Infrastructure for Project Expansion

resource "aws_vpc" "Project-Expansion-VPC" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "Project-Expansion-VPC"
  }
}

resource "aws_subnet" "Expansion-Pub-Sub1" {
  vpc_id     = aws_vpc.Project-Expansion-VPC.id
  cidr_block = var.Pub_Sub1_cidr

  tags = {
    Name = "Expansion-Pub-Sub1"
  }
}

resource "aws_subnet" "Expansion-Pub-Sub2" {
  vpc_id     = aws_vpc.Project-Expansion-VPC.id
  cidr_block = var.Pub_Sub2_cidr

  tags = {
    Name = "Expansion-Pub-Sub2"
  }
}

resource "aws_subnet" "Expansion-Priv-Sub1" {
  vpc_id     = aws_vpc.Project-Expansion-VPC.id
  cidr_block = var.Priv_Sub1_cidr

  tags = {
    Name = "Expansion-Priv-Sub1"
  }
}

resource "aws_subnet" "Expansion-Priv-Sub2" {
  vpc_id     = aws_vpc.Project-Expansion-VPC.id
  cidr_block = var.Priv_Sub2_cidr

  tags = {
    Name = "Expansion-Priv-Sub2"
  }
}

resource "aws_route_table" "Expansion-Pub-RT" {
  vpc_id = aws_vpc.Project-Expansion-VPC.id

tags = {
    Name = "Expansion-Pub-RT"
  }
}

resource "aws_route_table" "Expansion-Priv-RT" {
  vpc_id = aws_vpc.Project-Expansion-VPC.id

tags = {
    Name = "Expansion-Priv-RT"
  }
}

resource "aws_route_table_association" "Pub-RTA1" {
  subnet_id      = aws_subnet.Expansion-Pub-Sub1.id
  route_table_id = aws_route_table.Expansion-Pub-RT.id
}

resource "aws_route_table_association" "Pub-RTA2" {
  subnet_id      = aws_subnet.Expansion-Pub-Sub2.id
  route_table_id = aws_route_table.Expansion-Pub-RT.id
}

resource "aws_route_table_association" "Priv-RTA1" {
  subnet_id      = aws_subnet.Expansion-Priv-Sub1.id
  route_table_id = aws_route_table.Expansion-Priv-RT.id
}

resource "aws_route_table_association" "Priv-RTA2" {
  subnet_id      = aws_subnet.Expansion-Priv-Sub2.id
  route_table_id = aws_route_table.Expansion-Priv-RT.id
}

resource "aws_internet_gateway" "Expansion-igw" {
  vpc_id = aws_vpc.Project-Expansion-VPC.id

  tags = {
    Name = "Expansion-igw"
  }
}

resource "aws_route" "Public-route" {
  route_table_id            = aws_route_table.Expansion-Pub-RT.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.Expansion-igw.id
}

resource "aws_eip" "Expansion-Nat-eip" {
  domain   = "vpc"
  
  tags = {
    Name = "Expansion-Nat-eip"
}
}

resource "aws_nat_gateway" "Expansion-Nat-gateway" {
  allocation_id = aws_eip.Expansion-Nat-eip.id
  subnet_id     = aws_subnet.Expansion-Priv-Sub1.id

  tags = {
    Name = "Expansion-Nat-gateway"
  }
  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.Expansion-igw]
}

resource "aws_route" "Private-route" {
  route_table_id            = aws_route_table.Expansion-Priv-RT.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_nat_gateway.Expansion-Nat-gateway.id
}  


