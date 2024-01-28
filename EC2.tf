# Provisioning an EC2
resource "aws_instance" "Expansion-EC2" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.Expansion-Pub-Sub1.id
  tags = {
    Name = "Expansion-EC2"
 }
}

# Creating a key pair
resource "aws_key_pair" "Expansion-KP" {
  key_name   = var.key_name
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits = 4096
}

# Saving the key pair in your local computer
resource "local_file" "Expansion-KP" {
  content = tls_private_key.rsa.private_key_pem
  filename = var.filename
}

# Creating security group
resource "aws_security_group" "Expansion_SG" {
  name        = var.security_group_name
  description = "Security group using terraform"
  vpc_id      = aws_vpc.Project-Expansion-VPC.id

  tags = {
    Name = "Expansion_SG"
  }
}

# Inbound rules
resource "aws_vpc_security_group_ingress_rule" "SSH" {
  security_group_id = aws_security_group.Expansion_SG.id
  cidr_ipv4         = aws_vpc.Project-Expansion-VPC.cidr_block
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "HTTP" {
  security_group_id = aws_security_group.Expansion_SG.id
  cidr_ipv4         = aws_vpc.Project-Expansion-VPC.cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

# Outbound rules
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.Expansion_SG.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.Expansion_SG.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_network_interface_sg_attachment" "SG-attachment" {
  security_group_id    = aws_security_group.Expansion_SG.id
  network_interface_id = aws_instance.Expansion-EC2.primary_network_interface_id
}

resource "aws_network_interface" "Expansion-NI" {
  subnet_id       = aws_subnet.Expansion-Pub-Sub1.id
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_security_group.Expansion_SG.id]

  attachment {
    instance     = aws_instance.Expansion-EC2.id
    device_index = 1
  }
}