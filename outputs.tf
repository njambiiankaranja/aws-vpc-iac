output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public_1.id
}

output "private_subnet_id" {
  description = "ID of the private subnet"
  value       = aws_subnet.private_1.id
}

output "nat_gateway_public_ip" {
  description = "Public IP that outbound traffic from the private subnet appears to come from"
  value       = aws_eip.nat.public_ip
}

output "web_security_group_id" {
  description = "ID of the web security group (HTTP from anywhere, SSH from my_ip)"
  value       = aws_security_group.web_sg.id
}