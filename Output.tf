# Getting all the necessary IDs

output "vpc_id" {
  value = aws_vpc.Project-Expansion-VPC.id
}

output "Expansion-Pub-Sub1_id" {
  value = aws_subnet.Expansion-Pub-Sub1.id
}

output "Expansion-Pub-Sub2_id" {
  value = aws_subnet.Expansion-Pub-Sub2.id
}

output "Expansion-Priv-Sub1_id" {
  value = aws_subnet.Expansion-Priv-Sub1.id
}

output "Expansion-Priv-Sub2_id" {
  value = aws_subnet.Expansion-Priv-Sub2.id
}

output "Expansion-Pub-RT_id" {
  value = aws_route_table.Expansion-Pub-RT.id
}

output "Expansion-Priv-RT_id" {
  value = aws_route_table.Expansion-Priv-RT.id
}

output "Expansion-igw_id" {
  value = aws_internet_gateway.Expansion-igw.id
}

output "Expansion-Nat-eip_id" {
  value = aws_eip.Expansion-Nat-eip.id
}

output "Expansion-Nat-gateway_id" {
  value = aws_nat_gateway.Expansion-Nat-gateway.id
}

output "Expansion-EC2-Insance_id" {
  value = aws_instance.Expansion-EC2.id
}